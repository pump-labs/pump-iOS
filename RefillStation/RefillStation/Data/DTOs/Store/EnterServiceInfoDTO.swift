//
//  RequestEnterServiceDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/05/08.
//

import Foundation

struct EnterServiceInfoDTO: Decodable {
    let isRequested: Bool
    let count: Int
}

struct RequestEnterServiceRequestDTO: Encodable {
    let storeId: Int
}

extension EnterServiceInfoDTO {
    func toResponseValue() -> FetchEnterToServiceCountResponseValue {
        return .init(requestCount: count, didRequested: isRequested)
    }

    func toResponseValue() -> RequestEnterToServiceResponseValue {
        return .init(requestCount: count, didRequested: isRequested)
    }
}
