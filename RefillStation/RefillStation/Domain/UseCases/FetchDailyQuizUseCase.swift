//
//  FetchDailyQuizUseCase.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

protocol FetchDailyQuizUseCaseInterFace {
    func execute() async throws -> DailyQuiz
}

final class FetchDailyQuizUseCase: FetchDailyQuizUseCaseInterFace {
    private let dailyQuizRepository: AsyncDailyQuizRepositoryInterface

    init(dailyQuizRepository: AsyncDailyQuizRepositoryInterface = AsyncDailyQuizRepository()) {
        self.dailyQuizRepository = dailyQuizRepository
    }

    func execute() async throws -> DailyQuiz {
        return .init(quiz: "", selections: [], answer: "", hint: "")
    }
}
