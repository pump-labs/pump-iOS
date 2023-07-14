//
//  DailyQuizCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import UIKit

final class DailyQuizCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: DailyQuizCollectionViewCell.self)

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "퀴즈 풀러가기"
        label.textAlignment = .center
        label.applyFont(font: .titleMedium)
        label.textColor = Asset.Colors.gray0.color
        label.backgroundColor = Asset.Colors.primary9.color
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(10)
        }
    }
}
