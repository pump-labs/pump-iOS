//
//  NoProductCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/05/05.
//

import UIKit

final class NoProductCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: NoProductCell.self)

    var buttonTapped: (() -> Void)?

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.applyFont(font: .bodyMediumOverTwoLine)
        label.textColor = Asset.Colors.gray4.color
        label.text = "아직 판매상품 정보가 없어요.\n버튼을 눌러주시면 가게에 의견을 전달드려요."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let curiousLabel: UILabel = {
        let label = UILabel()
        label.applyFont(font: .buttonLarge)
        label.textColor = Asset.Colors.gray6.color
        label.text = "판매상품이 궁금해요"
        return label
    }()

    private lazy var productCuriousButtonView: UIView = {
        let buttonView = UIView()
        let pumpCharacterImageView = UIImageView(image: Asset.Images.pumping.image)
        pumpCharacterImageView.layer.cornerRadius = 10
        buttonView.backgroundColor = .white
        [pumpCharacterImageView, curiousLabel].forEach { buttonView.addSubview($0) }
        pumpCharacterImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.top.leading.bottom.equalToSuperview().inset(12)
        }
        curiousLabel.snp.makeConstraints {
            $0.leading.equalTo(pumpCharacterImageView.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview().inset(13)
            $0.trailing.equalToSuperview().inset(13)
        }
        buttonView.layer.cornerRadius = 22
        buttonView.layer.borderWidth = 1
        buttonView.layer.borderColor = Asset.Colors.gray3.color.cgColor
        buttonView.isUserInteractionEnabled = true
        buttonView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                               action: #selector(buttonViewTapped)))
        return buttonView
    }()

    private let curiousCountLabel: UILabel = {
        let label = UILabel()
        label.applyFont(font: .captionLarge)
        label.textColor = Asset.Colors.gray4.color
        label.text = "가장 먼저 버튼을 눌러주세요"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        [descriptionLabel, productCuriousButtonView, curiousCountLabel].forEach {
            contentView.addSubview($0)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(64)
            $0.leading.trailing.equalToSuperview().inset(55)
        }

        productCuriousButtonView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(174)
        }

        curiousCountLabel.snp.makeConstraints {
            $0.top.equalTo(productCuriousButtonView.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
    }

    @objc
    private func buttonViewTapped() {
        productCuriousButtonView.backgroundColor = Asset.Colors.primary1.color
        curiousLabel.textColor = Asset.Colors.primary9.color
        curiousCountLabel.changeColor(targetString: "먼저", color: Asset.Colors.primary9.color)
        buttonTapped?()
    }
}

fileprivate extension UILabel {
    func changeColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}
