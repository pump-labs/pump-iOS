//
//  DefaultTagReviewViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/24.
//

import UIKit

protocol TagReviewViewModelInput {
}

protocol TagReviewViewModelOutput {
}

protocol TagReviewViewModel: TagReviewViewModelInput, TagReviewViewModelOutput { }

final class DefaultTagReviewViewModel: TagReviewViewModel {

    let storeName: String
    let storeLocationInfo: String
    var reviewPhotos: [UIImage] = []
    var reviewContents: String = ""
    var indexPathsForSelectedItems = [IndexPath]()
    var shouldSelectCell: Bool {
        return indexPathsForSelectedItems.count < 3
    }

    init(storeName: String, storeLocationInfo: String) {
        self.storeName = storeName
        self.storeLocationInfo = storeLocationInfo
    }

    func didSelectItemAt(indexPath: IndexPath) {
        indexPathsForSelectedItems.append(indexPath)
    }

    func didDeselectItemAt(indexPath: IndexPath) {
        if let indexPathToRemove = indexPathsForSelectedItems.firstIndex(of: indexPath) {
            indexPathsForSelectedItems.remove(at: indexPathToRemove)
        }
    }
}
