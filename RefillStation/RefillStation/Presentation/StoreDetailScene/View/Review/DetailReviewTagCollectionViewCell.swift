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
        imageView.backgroundColor = Asset.Colors.gray3.color
        return imageView
    }()

    private let tagTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray5.color
        label.font = UIFont.font(style: .bodyMedium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(tag: Tag) {
        tagTitleLabel.text = tag.title
        tagImageView.image = tag.image
    }

    private func layout() {
        [tagImageView, tagTitleLabel].forEach { contentView.addSubview($0) }
        tagImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(tagImageView.snp.height)
        }
        tagTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(tagImageView.snp.trailing).offset(5)
            $0.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
