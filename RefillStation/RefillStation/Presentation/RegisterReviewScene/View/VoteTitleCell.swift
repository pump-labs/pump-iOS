//
//  VoteTitleCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/11/26.
//

import UIKit
import SnapKit

final class VoteTitleCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: VoteTitleCell.self)

    private let voteTitleLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "이 매장의 좋은 점은 무엇인가요?", font: .titleMedium)
        label.textColor = Asset.Colors.gray7.color
        return label
    }()

    private let maximumVoteLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "(1~3개)", font: .titleMedium)
        label.textColor = Asset.Colors.gray3.color
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        [voteTitleLabel, maximumVoteLabel].forEach {
            contentView.addSubview($0)
        }

        voteTitleLabel.snp.makeConstraints { titleLabel in
            titleLabel.top.equalToSuperview().inset(20)
            titleLabel.bottom.equalToSuperview().inset(16)
            titleLabel.leading.equalToSuperview()
        }

        voteTitleLabel.setContentHuggingPriority(.required, for: .horizontal)
        voteTitleLabel.setContentHuggingPriority(.required, for: .vertical)
        voteTitleLabel.sizeToFit()

        maximumVoteLabel.snp.makeConstraints { voteLabel in
            voteLabel.leading.equalTo(voteTitleLabel.snp.trailing).offset(5)
            voteLabel.trailing.equalToSuperview()
            voteLabel.top.bottom.equalTo(voteTitleLabel)
        }
    }
}
