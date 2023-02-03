//
//  AccountRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/25.
//

import Foundation

protocol AccountRepositoryInterface {
    func OAuthLogin(loginType: OAuthType, completion: @escaping (Result<String?, Error>) -> Void) -> Cancellable?

    func signUp(requestValue: SignUpRequestValue, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?

    func withdraw(completion: @escaping (Result<Void, Error>) -> Void) -> Cancellable?

    func createNickname(completion: @escaping (Result<String, Error>) -> Void) -> Cancellable?
}