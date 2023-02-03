//
//  NicknameViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/01/22.
//

import UIKit

final class NicknameViewModel {
    let viewType: ViewType
    var profileImage: String?
    var randomNickname = "냥냥이에오123"
    var userNickname = "kong"
    var isVaild = true

    init(viewType: ViewType) {
        self.viewType = viewType
    }

    func setNicknameState(count: Int) -> NicknameState {
        if count == 0 {
            return .empty
        } else if count < 2 {
            return .underTwoCharacters
        } else if count > 10 {
            return .overTenCharacters
        } else {
            return .correct
        }
    }

    func isValidCharacters(string: String) -> Bool {
        let utf8Char = string.cString(using: .utf8)
        let isBackSpace = strcmp(utf8Char, "\\b")
        if string.hasVaildCharacters() || isBackSpace == -92 { return true }
        return false
    }
}

fileprivate extension String {
    func hasVaildCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9]$",
                                                options: .caseInsensitive)
            if regex.firstMatch(in: self,
                                options: NSRegularExpression.MatchingOptions.reportCompletion,
                                range: NSRange(location: 0, length: self.count)) != nil {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}

extension NicknameViewModel {
    enum ViewType {
        case onboarding
        case myPage
    }

    enum NicknameState {
        case empty
        case underTwoCharacters
        case overTenCharacters
        case correct

        var description: String {
            switch self {
            case .empty:
                return "닉네임을 입력해주세요"
            case .underTwoCharacters:
                return "닉네임은 2자 이상 입력해주세요"
            case .overTenCharacters:
                return "닉네임은 10자 이하로 입력해주세요"
            case .correct:
                return ""
            }
        }
        var borderColor: CGColor {
            switch self {
            case .empty:
                return Asset.Colors.gray4.color.cgColor
            case .underTwoCharacters, .overTenCharacters:
                return Asset.Colors.error.color.cgColor
            case .correct:
                return Asset.Colors.gray4.color.cgColor
            }
        }
        var textColor: UIColor {
            switch self {
            case .empty:
                return Asset.Colors.gray3.color
            case .underTwoCharacters, .overTenCharacters:
                return Asset.Colors.error.color
            case .correct:
                return .clear
            }
        }
    }
}