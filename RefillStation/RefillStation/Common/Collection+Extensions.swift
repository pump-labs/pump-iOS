//
//  Collection+Extensions.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import Foundation

extension Collection {
    func lastElementIndex() -> Int? {
        guard !self.isEmpty else { return nil }
        guard let endIndex = endIndex as? Int else {
            return nil
        }
        return endIndex - 1
    }
}
