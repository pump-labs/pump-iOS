//
//  StoreReviewSection.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/29.
//

import UIKit

extension StoreReviewViewController {

    enum Section: Int, CaseIterable {
        case moveToWriteReview
        case firstReviewRequest
        case VotedCountLabel
        case VotedTagCollectionView
        case detailReviewCount
        case DetailReviewCollectionView

        var cellHeight: CGFloat {
            switch self {
            case .moveToWriteReview:
                return 40
            case .firstReviewRequest:
                return 190
            case .VotedCountLabel:
                return 40
            case .VotedTagCollectionView:
                return 240
            case .detailReviewCount:
                return 40
            case .DetailReviewCollectionView:
                return 200
            }
        }
    }
}
