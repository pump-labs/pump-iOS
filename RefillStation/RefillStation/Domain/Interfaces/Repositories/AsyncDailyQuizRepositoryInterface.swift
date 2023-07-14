//
//  AsyncDailyQuizRepositoryInterface.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

protocol AsyncDailyQuizRepositoryInterface {
    func fetchDailyQuiz() async throws -> DailyQuiz
}
