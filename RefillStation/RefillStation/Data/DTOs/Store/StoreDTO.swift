//
//  StoreDTO.swift
//  RefillStation
//
//  Created by 천수현 on 2023/02/04.
//

import Foundation

struct StoreDTO: Decodable {
    let id: Int?
    let userId: Int?
    let name: String?
    let status: String?
    let longitude: String?
    let latitude: String?
    let businessHour: [BusinessHourDTO]?
    let notice: String?
    let address: String?
    let instaAccount: String?
    let callNumber: String?
    let registrationNumber: String?
    let isReady: String?
    let distance: String?
    let imgStores: [ImgStoreDTO]

    struct BusinessHourDTO: Decodable {
        let day: String?
        let time: String?
    }

    struct ImgStoreDTO: Decodable {
        let id: Int?
        let storeId: Int?
        let path: String?
    }
}

struct StoreFetchResult {
    let storeId: Int
    let name: String
    let address: String
    let distance: Double
    let phoneNumber: String
    let snsAddress: String
    let imageURL: [String]
    let businessHour: [BusinessHour]
    let notice: String
}

extension StoreDTO {
    func toFetchResult() -> StoreFetchResult {
        return StoreFetchResult(
            storeId: id ?? 0,
            name: name ?? "",
            address: address ?? "",
            distance: Double(distance ?? "") ?? 0,
            phoneNumber: callNumber ?? "",
            snsAddress: instaAccount ?? "",
            imageURL: imgStores.compactMap { $0.path },
            businessHour: businessHour?.map { dto in
                BusinessHour(day: .allCases.first(where: {
                    $0.name == dto.day
                }) ?? .mon, time: dto.time)
            } ?? [],
            notice: notice ?? ""
        )
    }

    func toDomain() -> Store {
        return Store(
            storeId: id ?? 0,
            name: name ?? "",
            address: address ?? "",
            distance: Double(distance ?? "") ?? 0,
            phoneNumber: callNumber ?? "",
            snsAddress: instaAccount ?? "",
            didUserRecommended: false,
            recommendedCount: 0,
            imageURL: imgStores.compactMap { $0.path },
            businessHour: businessHour?.map { dto in
                BusinessHour(day: .allCases.first(where: {
                    $0.name == dto.day
                }) ?? .mon, time: dto.time)
            } ?? [],
            notice: notice ?? ""
        )
    }
}
