//
//  FetchEnterToServiceCountUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/05/08.
//

import Foundation

struct FetchEnterToServiceCountResponseValue {
    let requestCount: Int
    let didRequested: Bool
}

protocol FetchEnterToServiceCountUseCaseInterface {
    func execute(storeId: Int) async throws -> FetchEnterToServiceCountResponseValue
}

final class FetchEnterToServiceCountUseCase: FetchEnterToServiceCountUseCaseInterface {

    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(storeId: Int) async throws -> FetchEnterToServiceCountResponseValue {
        return try await storeRepository.fetchEnterToServiceRequestCount(storeId: storeId)
    }
}
