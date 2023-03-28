//
//  AsyncHealthCheckRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/27.
//

import Foundation

protocol AsyncSplashRepositoryInterface {
    func healthCheck() async throws -> Bool
}
