//
//  OperationInfoView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/07.
//

import UIKit

final class OperationInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: OperationInfoCell.self)

    private let contentLabelDefaultHeight: CGFloat = 20
    private let contentLabelInsetSum: CGFloat = 165

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Asset.Colors.primary8.color
        return imageView
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.font(style: .bodySmallOverTwoLine)
        label.textColor = Asset.Colors.gray6.color
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(contentLabel)
        return stackView
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray1.color
        return line
    }()

    private lazy var seeMoreButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        button.isHidden = true
        return button
    }()

    var seeMoreTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.backgroundColor = .white
        layout()
        addSeeMoreButtonAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        seeMoreButton.isHidden = true
        contentLabel.textColor = Asset.Colors.gray6.color
    }

    func setUpContents(
        operation: OperationInfo,
        shouldShowMore: Bool = false,
        screenWidth: CGFloat = 0
    ) {
        let targetWidth = screenWidth == 0 ?
        contentView.frame.width - contentLabelInsetSum : screenWidth - contentLabelInsetSum
        imageView.image = operation.type.image
        contentLabel.setText(text: operation.content, font: .bodySmallOverTwoLine)
        if let url = URL(string: operation.content),
           UIApplication.shared.canOpenURL(url) {
            contentLabel.textColor = Asset.Colors.primary8.color
            contentLabel.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(contentLabelTapped(_:)))
            contentLabel.addGestureRecognizer(tapGesture)
        }

        if operation.type == .time { setUpTimeOperationCell(operation: operation, shouldShowMore: shouldShowMore) }
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.lineBreakStrategy = .hangulWordPriority

        let newSize = contentLabel.sizeThatFits(CGSize(width: targetWidth, height: CGFloat.greatestFiniteMagnitude))
        let newHeight = newSize.height == 0 ? 20 : newSize.height
        contentLabel.snp.remakeConstraints {
            $0.height.equalTo(newHeight).priority(.required)
        }
    }

    private func setUpTimeOperationCell(operation: OperationInfo, shouldShowMore: Bool) {
        seeMoreButton.isHidden = false

        if shouldShowMore {
            contentLabel.numberOfLines = 0
            seeMoreButton.setImage(Asset.Images.iconArrowTopSmall.image, for: .normal)
        } else {
            contentLabel.numberOfLines = 1
            seeMoreButton.setImage(Asset.Images.iconArrowBottomSmall.image, for: .normal)
        }

        if let firstLineText = operation.content.split(separator: "\n").first {
            contentLabel.makeBold(targetString: String(firstLineText))
        }
    }

    private func maximumContentLabelHeight(targetWidth: CGFloat) -> CGFloat {
        let tempContentLabelNumberOfLines = contentLabel.numberOfLines

        contentLabel.numberOfLines = 0
        let maxSize = contentLabel.sizeThatFits(CGSize(width: targetWidth,
                                                       height: CGFloat.greatestFiniteMagnitude))
        let maxHeight = maxSize.height == 0 ? 20 : maxSize.height
        contentLabel.numberOfLines = tempContentLabelNumberOfLines
        return maxHeight
    }

    private func makeFirstLineBold(operation: OperationInfo) {
        if let targetString = operation.content.split(separator: "\n").map({ String($0) }).first {
            contentLabel.makeBold(targetString: targetString)
        }
    }

    private func layout() {
        [imageView, contentStackView, divisionLine, seeMoreButton].forEach {
            contentView.addSubview($0)
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel)
            $0.leading.equalToSuperview().inset(16)
            $0.width.height.equalTo(20)
        }

        contentStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
            $0.trailing.equalTo(seeMoreButton.snp.leading).offset(-8)
        }

        contentStackView.addArrangedSubview(contentLabel)

        contentLabel.snp.remakeConstraints {
            $0.height.equalTo(contentLabelDefaultHeight)
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(contentStackView.snp.bottom).offset(15)
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }

        seeMoreButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(29)
            $0.bottom.equalToSuperview()
            $0.height.width.equalTo(46)
        }
    }

    private func addSeeMoreButtonAction() {
        seeMoreButton.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            self.seeMoreTapped?()
        }, for: .touchUpInside)
    }

    @objc
    private func contentLabelTapped(_ sender: UITapGestureRecognizer) {
        if let contentText = contentLabel.text,
           let url = URL(string: contentText),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

struct OperationInfo: Hashable {
    enum `Type` {
        case time
        case phoneNumber
        case link
        case address

        var image: UIImage? {
            switch self {
            case .time:
                return Asset.Images.iconClock.image.withRenderingMode(.alwaysTemplate)
            case .phoneNumber:
                return Asset.Images.iconOperationCall.image.withRenderingMode(.alwaysTemplate)
            case .link:
                return Asset.Images.iconOperationLink.image.withRenderingMode(.alwaysTemplate)
            case .address:
                return Asset.Images.iconLocation.image.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    let type: `Type`
    let content: String
}

fileprivate extension UILabel {
    func makeBold(targetString: String) {
        let font = UIFont.boldSystemFont(ofSize: self.font.pointSize)
        let fullText = self.text ?? ""
        let range = (fullText as NSString).range(of: targetString)
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.font, value: font, range: range)
        self.attributedText = attributedString
    }
}
