//
//  DailyQuiz.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

struct DailyQuiz {
    let quiz: String
    let selections: [Selection]
    let answer: String
    let hint: String

    struct Selection {
        let number: Int
        let text: String
    }
}
