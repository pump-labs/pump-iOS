//
//  UILabel+Font.swift
//  Design
//
//  Created by 천수현 on 2023/04/08.
//  Copyright © 2023 com.neph. All rights reserved.
//

import UIKit

extension UILabel {
    func applyFont(font: TextStyles) {
        self.font = .font(style: font)
        lineHeight = font.lineHeight
        letterSpacing = font.letterSpacing
    }
}
