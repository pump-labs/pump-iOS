//
//  HealthCheckUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/27.
//

import Foundation

protocol HealthCheckUseCaseInterface {
    func execute() async throws -> Bool
}

final class HealthCheckUseCase: HealthCheckUseCaseInterface {
    private let splashRepository: AsyncSplashRepositoryInterface

    init(splashRepository: AsyncSplashRepositoryInterface = AsyncSplashRepository()) {
        self.splashRepository = splashRepository
    }

    func execute() async throws -> Bool {
        return try await splashRepository.healthCheck()
    }
}
