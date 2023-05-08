//
//  Typography.swift
//  UILabel_Typography_Extensions
//
//  Copyright © 2020. Geri Borbás. All rights reserved.
//  https://twitter.com/Geri_Borbas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


import UIKit


public protocol TypographyExtensions: UILabel {
	
	/// Set the line height (points) on the underlying `NSAttributedString` (with
	/// vertical centering). The provided `lineHeight` value is set to the
	/// `minimumLineHeight` and `maximumLineHeight` property of the `paragraphStyle`
	/// attribute.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated). In order to preserve consistent `baselineOffset` behavior,
	/// the `attributedText` property gets updated whenever the `text` property of
	/// the label changes.
	var lineHeight: CGFloat? { get set }
	
	/// Set the letter spacing (kerning) on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var letterSpacing: CGFloat? { get set }
	
	/// Set the underline style on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var underline: NSUnderlineStyle? { get set }
	
	/// Set the strikethrough style on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var strikethrough: NSUnderlineStyle? { get set }
}


public class Typography {
		
	var lineHeight: CGFloat? = nil
	var letterSpacing: CGFloat? = nil
	var underline: NSUnderlineStyle? = nil
	var strikethrough: NSUnderlineStyle? = nil

	func set<ValueType: Equatable>(_ value: ValueType, for keyPath: ReferenceWritableKeyPath<Typography, ValueType>, onChange: () -> Void) {
		if self[keyPath: keyPath] != value {
			self[keyPath: keyPath] = value
			onChange()
		}
	}
}
