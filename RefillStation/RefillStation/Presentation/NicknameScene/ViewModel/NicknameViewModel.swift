//
//  NicknameViewModel.swift
//  RefillStation
//
//  Created by kong on 2023/01/22.
//

import UIKit

final class NicknameViewModel {
    private let editProfileUseCase: EditProfileUseCaseInterface
    private let validNicknameUseCase: ValidNicknameUseCaseInterface
    private var user: User
    let viewType: ViewType

    private var editProfileTask: Cancellable?
    private var validNicknameTask: Cancellable?

    var didEditComplete: (() -> Void)?
    var isValidNickname: ((Bool) -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?
    var didImageChanged: Bool = false

    var profileImage: String? {
        return user.imageURL
    }

    var userNickname: String {
        return user.name
    }

    var isDuplicated = false

    init(viewType: ViewType,
         user: User,
         editProfileUseCase: EditProfileUseCaseInterface,
         validNicknameUseCase: ValidNicknameUseCaseInterface) {
        self.viewType = viewType
        self.user = user
        self.editProfileUseCase = editProfileUseCase
        self.validNicknameUseCase = validNicknameUseCase
    }

    func setNicknameState(count: Int) -> NicknameState {
        if count == 0 {
            return .empty
        } else if count < 2 {
            return .underTwoCharacters
        } else if count > 20 {
            return .overTwentyCharacters
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

    func confirmButtonDidTapped(nickname: String?,
                                profileImage: UIImage?) {
       editProfileTask = Task {
            let requestValue = EditProfileRequestValue(
                nickname: nickname ?? "",
                rating: user.level.level.rawValue,
                newImage: profileImage,
                oldImagePath: user.imageURL,
                didImageChanged: didImageChanged
            )
            let user = try await editProfileUseCase.execute(requestValue: requestValue)
            self.user = user
            didEditComplete?()
        }
    }

    func validNickname(nickname: String) {
        validNicknameTask = Task {
            do {
                let requestValue = ValidNicknameRequestValue(nickname: nickname)
                let isDuplicated = try await validNicknameUseCase.execute(requestValue: requestValue)
                self.isDuplicated = isDuplicated
                isValidNickname?(isDuplicated)
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }
}

extension NicknameViewModel {
    func viewWillDisappear() {
        [editProfileTask, validNicknameTask].forEach { $0?.cancel() }
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
        case overTwentyCharacters
        case correct

        var description: String {
            switch self {
            case .empty:
                return "닉네임을 입력해주세요"
            case .underTwoCharacters:
                return "닉네임은 2자 이상 입력해주세요"
            case .overTwentyCharacters:
                return "닉네임은 20자 이하로 입력해주세요"
            case .correct:
                return ""
            }
        }
        var borderColor: CGColor {
            switch self {
            case .empty:
                return Asset.Colors.gray4.color.cgColor
            case .underTwoCharacters, .overTwentyCharacters:
                return Asset.Colors.error.color.cgColor
            case .correct:
                return Asset.Colors.gray4.color.cgColor
            }
        }
        var textColor: UIColor {
            switch self {
            case .empty:
                return Asset.Colors.gray3.color
            case .underTwoCharacters, .overTwentyCharacters:
                return Asset.Colors.error.color
            case .correct:
                return .clear
            }
        }
    }
}
