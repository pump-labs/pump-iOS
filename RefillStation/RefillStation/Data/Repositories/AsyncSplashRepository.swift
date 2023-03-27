//
//  AsyncSplashRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/27.
//

import Foundation

final class AsyncSplashRepository: AsyncSplashRepositoryInterface {
    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
    }

    func healthCheck() async throws -> Bool {
        var urlComponents = URLComponents(string: networkService.baseURL)
        urlComponents?.path = "/api/common/heartbeat"
        guard let request = urlComponents?.toURLRequest(method: .get) else {
            throw RepositoryError.urlParseFailed
        }
        let response = try await networkService.dataTask(request: request)
        return response.statusCode == 200
    }
}
