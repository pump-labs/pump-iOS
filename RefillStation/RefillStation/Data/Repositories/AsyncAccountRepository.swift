//
//  AsyncAccountRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/11.
//

import Foundation

final class AsyncAccountRepository: AsyncAccountRepositoryInterface {

    private let networkService: NetworkServiceInterface
    private let keychainManager: KeychainManagerInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared,
         keychainManager: KeychainManagerInterface = KeychainManager.shared
    ) {
        self.networkService = networkService
        self.keychainManager = keychainManager
    }

    func OAuthLogin(loginType: OAuthType, requestValue: OAuthLoginRequestValue) async throws -> OAuthLoginResponseValue {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = loginType == .lookAround ? "/api/user/test-account" : "/api/login/oauth/\(loginType.path)"
        let requestParamName = loginType == .apple ? "identityToken" : "accessToken"
        urlComponents?.queryItems = loginType == .lookAround ? [] : [
            URLQueryItem(name: requestParamName, value: String(requestValue.accessToken))
        ]
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }
        let loginDTO: LoginDTO = try await networkService.dataTask(request: request)
        if let token = loginDTO.jwt {
            _ = keychainManager.deleteUserToken()
            if loginType == .lookAround {
                _ = keychainManager.addItem(key: "lookAroundToken", value: token)
                UserDefaults.standard.setValue(true, forKey: "isLookAroundUser")
            } else {
                _ = keychainManager.addItem(key: "token", value: token)
            }
        }
        return loginDTO.toDomain()
    }

    func signUp(requestValue: SignUpRequestValue) async throws -> String {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user/register"
        guard let requestBody = try? JSONEncoder().encode(
            SignUpReqeustDTO(name: requestValue.name,
                             email: requestValue.email,
                             imagePath: requestValue.imagePath,
                             oauthType: requestValue.oauthType,
                             oauthIdentity: requestValue.oauthIdentity)
        ) else {
            throw RepositoryError.requestParseFailed
        }
        guard let request = urlComponents?.toURLRequest(method: .post, httpBody: requestBody) else {
            throw RepositoryError.urlParseFailed
        }
        let token: String = try await networkService.dataTask(request: request)
        _ = keychainManager.deleteUserToken()
        _ = keychainManager.addItem(key: "token", value: token)
        return token
    }

    func signOut() async throws {
        let result = keychainManager.deleteUserToken()
        switch result {
        case .success:
            UserDefaults.standard.setValue(false, forKey: "isLookAroundUser")
            UserDefaults.standard.setValue(false, forKey: "didLookAroundLoginStarted")
            UserDefaults.standard.setValue(false, forKey: "didRequestRegion")
        case .failure(let error):
            throw error
        }
    }

    func withdraw() async throws {
        _ = keychainManager.deleteItem(key: "lookAroundToken")
        guard keychainManager.getItem(key: "token") != nil else { return }
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/user"
        guard let request = urlComponents?.toURLRequest(method: .delete) else {
            throw RepositoryError.urlParseFailed
        }

        let _: WithdrawDTO = try await networkService.dataTask(request: request)
        _ = keychainManager.deleteUserToken()
        UserDefaults.standard.setValue(false, forKey: "isLookAroundUser")
        UserDefaults.standard.setValue(false, forKey: "didLookAroundLoginStarted")
        UserDefaults.standard.setValue(false, forKey: "didRequestRegion")
    }
}
