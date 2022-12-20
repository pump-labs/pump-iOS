//
//  MockData.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

extension StoreReviewViewController {
    func makeMockDetailReviewViewModel() -> DetailReviewViewModel {
        let viewModel = DetailReviewViewModel()
        viewModel.detailReviews = [
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description"),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description"),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description"),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description"),
            .init(user: .init(name: "hello", imageURL: ""),
                  writtenDate: Date(),
                  imageURL: "",
                  description: "description")
        ]
        return viewModel
    }

    func makeMockVoteTagViewModel() -> VotedTagViewModel {
        let viewModel = VotedTagViewModel()
        viewModel.totalVoteCount = 2
        viewModel.tagReviews = [
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "친절해요"),
                  recommendedCount: 3),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "청결해요"),
                  recommendedCount: 4),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "배고파요"),
                  recommendedCount: 5),
            .init(tag: .init(image: UIImage(systemName: "zzz") ?? UIImage(), title: "살려줘요"),
                  recommendedCount: 6)
        ]

        return viewModel
    }
}