//
//  Store.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit

struct Store: Hashable {
    let name: String
    let address: String
    let distance: Double
    let phoneNumber: String
    let snsAddress: String
    let didUserRecommended: Bool
    let recommendedCount: Int
    let imageURL: [String]
    let businessHour: BusinessHour
}

struct BusinessHour: Hashable {
    enum Day {
        case mon, tue, wed, thu, fri, sat, sun

        var name: String {
            switch self {
            case .mon:
                return "월"
            case .tue:
                return "화"
            case .wed:
                return "수"
            case .thu:
                return "목"
            case .fri:
                return "금"
            case .sat:
                return "토"
            case .sun:
                return "일"
            }
        }
    }
    let day: Day
    let time: String?
}
