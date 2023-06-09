//
//  DetailReviewTagCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class DetailReviewTagCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "detailReviewTagCollectionViewCell"

    private let tagImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        label.font = UIFont.font(style: .captionLarge)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
        setUpCellAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tag: Tag) {
        tagTitleLabel.setText(text: tag.text, font: .captionLarge)
        tagImageView.image = tag.image
    }

    private func layout() {
        [tagImageView, tagTitleLabel].forEach { contentView.addSubview($0) }
        tagImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.top.bottom.equalTo(tagTitleLabel)
            $0.height.equalTo(tagImageView.snp.width)
        }

        tagTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(tagImageView.snp.trailing).offset(5)
            $0.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(4)
        }
        tagTitleLabel.setContentHuggingPriority(.required, for: .vertical)
    }

    private func setUpCellAppearance() {
        contentView.backgroundColor = Asset.Colors.gray1.color
        layer.cornerRadius = 4
        clipsToBounds = true
    }
}
