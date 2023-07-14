//
//  DailyQuizViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

final class DailyQuizViewModel {
    private let fetchDailyQuizUseCase: FetchDailyQuizUseCaseInterFace
    private var quizLoadTask: Cancellable?
    private(set) var dailyQuiz: DailyQuiz? {
        didSet {
            if let dailyQuiz {
                applyDailyQuiz?(dailyQuiz)
            }
        }
    }
    var applyDailyQuiz: ((DailyQuiz) -> Void)?

    init(fetchDailyQuizUseCase: FetchDailyQuizUseCaseInterFace = FetchDailyQuizUseCase()) {
        self.fetchDailyQuizUseCase = fetchDailyQuizUseCase
    }

    private func fetchDailyQuiz() {
        quizLoadTask = Task {
            do {
//                dailyQuiz = try await fetchDailyQuizUseCase.execute()
                dailyQuiz = .init(
                    quiz: "문제가 들어갈 자리",
                    selections: [
                        .init(number: 0, text: "선지 1번"),
                        .init(number: 1, text: "선지 2번"),
                        .init(number: 2, text: "선지 3번"),
                        .init(number: 3, text: "선지 4번"),

                            .init(number: 0, text: "선지 1번"),
                            .init(number: 1, text: "선지 2번"),
                            .init(number: 2, text: "선지 3번"),
                            .init(number: 3, text: "선지 4번"),

                            .init(number: 0, text: "선지 1번"),
                            .init(number: 1, text: "선지 2번"),
                            .init(number: 2, text: "선지 3번"),
                            .init(number: 3, text: "선지 4번"),

                            .init(number: 0, text: "선지 1번"),
                            .init(number: 1, text: "선지 2번"),
                            .init(number: 2, text: "선지 3번"),
                            .init(number: 3, text: "선지 4번"),
                    ],
                    answer: "정답 자리", // 이건 문항 번호로 수정 필요할듯?
                    hint: "힌트"
                )
            } catch {
                debugPrint(error)
            }
        }
    }
}

extension DailyQuizViewModel {
    func viewDidLoad() {
        fetchDailyQuiz()
    }
    func viewWillDisappear() {
        quizLoadTask?.cancel()
    }
}
