//
//  AsyncDailyQuizRepository.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

final class AsyncDailyQuizRepository: AsyncDailyQuizRepositoryInterface {

    private let networkService: NetworkServiceInterface

    init(networkService: NetworkServiceInterface = NetworkService.shared) {
        self.networkService = networkService
    }

    func fetchDailyQuiz() async throws -> DailyQuiz {
        return DailyQuiz(quiz: "", selections: [], answer: "", hint: "")
    }
}
