//
//  RequestEnterToServiceUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/05/08.
//

import Foundation

struct RequestEnterToServiceRequestValue {
    enum `Type` {
        case request
        case cancel
    }
    let storeId: Int
    let type: `Type`
}

struct RequestEnterToServiceResponseValue {
    let requestCount: Int
    let didRequested: Bool
}

protocol RequestEnterToServiceUseCaseInterface {
    func execute(requestValue: RequestEnterToServiceRequestValue) async throws -> RequestEnterToServiceResponseValue
}

final class RequestEnterToServiceUseCase: RequestEnterToServiceUseCaseInterface {

    private let storeRepository: AsyncStoreRepositoryInterface

    init(storeRepository: AsyncStoreRepositoryInterface = AsyncStoreRepository()) {
        self.storeRepository = storeRepository
    }

    func execute(requestValue: RequestEnterToServiceRequestValue) async throws -> RequestEnterToServiceResponseValue {
        return try await storeRepository.requestEnterToService(requestValue: requestValue)
    }
}
