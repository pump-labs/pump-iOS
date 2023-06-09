//
//  ReviewInfoCell.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/14.
//

import UIKit
import Algorithms

final class ReviewInfoCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: ReviewInfoCell.self)

    private let didVisitedLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray5.color
        label.setText(text: "매장에 방문한 적이 있다면?", font: .bodySmall)
        return label
    }()

    private let moveToRegisterReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 쓰기", for: .normal)
        button.titleLabel?.font = UIFont.font(style: .buttonMedium)
        button.setTitleColor(Asset.Colors.gray6.color, for: .normal)
        button.setImage(Asset.Images.iconEdit.image, for: .normal)
        button.tintColor = Asset.Colors.gray6.color
        button.semanticContentAttribute = .forceRightToLeft
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = .init(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()

    private lazy var registerReviewView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        view.layer.cornerRadius = 4
        [didVisitedLabel, moveToRegisterReviewButton].forEach { view.addSubview($0) }
        didVisitedLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(26)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        moveToRegisterReviewButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(14)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        return view
    }()

    private let storeStrengthLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "이 매장의 좋은점", font: .titleMedium)
        return label
    }()

    private let profileGroupImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.profileImageGroup.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let votedCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .buttonLarge)
        label.textColor = Asset.Colors.gray6.color
        return label
    }()

    private let participateLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "참여", font: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    private lazy var tagVoteCountView: UIView = {
        let view = UIView()
        [storeStrengthLabel, profileGroupImageView, votedCountLabel, participateLabel].forEach { view.addSubview($0) }
        storeStrengthLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }

        participateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(8)
        }

        votedCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(participateLabel.snp.leading)
            $0.top.bottom.equalToSuperview().inset(8)
        }

        profileGroupImageView.snp.makeConstraints {
            $0.trailing.equalTo(votedCountLabel.snp.leading).offset(-4)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        return view
    }()

    private let firstRankView: FirstRankView = {
        let firstRankView = FirstRankView()
        firstRankView.setUpContents(tag: Tag.clerkIsKind)
        return firstRankView
    }()

    private let divisionLine: UIView = {
        let line = UIView()
        line.backgroundColor = Asset.Colors.gray2.color
        return line
    }()

    private let otherClassStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()

    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.layer.cornerRadius = 16
        visualEffectView.clipsToBounds = true
        return visualEffectView
    }()

    private let greaterThanTenLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .font(style: .bodyMediumOverTwoLine)
        label.textAlignment = .center
        return label
    }()

    private let blurLabelView: UIView = {
        let labelView = UIView()
        labelView.layer.cornerRadius = 6
        labelView.backgroundColor = .white
        labelView.layer.shadowRadius = 6
        labelView.layer.shadowColor = UIColor.black.cgColor
        labelView.layer.shadowOffset = CGSize(width: 0, height: 3)
        labelView.layer.shadowOpacity = 0.5
        labelView.layer.masksToBounds = false
        return labelView
    }()

    private lazy var tagReviewRankView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = Asset.Colors.gray0.color
        [firstRankView, divisionLine, otherClassStackView].forEach { view.addSubview($0) }

        firstRankView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalToSuperview()
        }

        divisionLine.snp.makeConstraints {
            $0.top.equalTo(firstRankView.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(1)
        }

        otherClassStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.top.equalTo(divisionLine.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(28)
        }
        return view
    }()

    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.gray1.color
        return view
    }()

    private let reviewTextLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "리뷰", font: .titleMedium)
        return label
    }()

    private let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .titleMedium)
        label.textColor = Asset.Colors.lv2.color
        return label
    }()

    private lazy var reviewCountView: UIView = {
        let view = UIView()
        [dividerView, reviewTextLabel, reviewCountLabel].forEach { view.addSubview($0) }
        dividerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(8)
        }
        reviewTextLabel.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
        reviewCountLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewTextLabel.snp.trailing).offset(6)
            $0.top.equalTo(reviewTextLabel)
            $0.bottom.equalToSuperview()
        }
        return view
    }()

    var moveToRegisterReview: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
        addMoveToRegisterReviewAction()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(totalDetailReviewCount: Int, totalTagReviewCount: Int, rankTags: [StoreDetailViewModel.RankTag]) {
        var rank = 1
        otherClassStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        reviewCountLabel.setText(text: "\(totalDetailReviewCount)", font: .titleMedium)

        if totalDetailReviewCount == 0 {
            [profileGroupImageView, participateLabel, votedCountLabel].forEach { $0.isHidden = true }
            makeBlurPlaceholder(reviewInfoCase: .noReviews)
            return
        } else if totalTagReviewCount == 0 {
            [profileGroupImageView, participateLabel, votedCountLabel].forEach { $0.isHidden = true }
            makeBlurPlaceholder(reviewInfoCase: .noTagReviews)
            return
        } else if totalTagReviewCount < 10 {
            profileGroupImageView.isHidden = true
            [participateLabel, votedCountLabel].forEach { $0.isHidden = false }
            votedCountLabel.setText(text: "현재까지 \(totalTagReviewCount)명 ", font: .buttonLarge)
            makeBlurPlaceholder(reviewInfoCase: .underTenReviews)
            return
        } else {
            [profileGroupImageView, participateLabel, votedCountLabel].forEach { $0.isHidden = false }
            votedCountLabel.setText(text: "\(totalTagReviewCount)명 ", font: .buttonLarge)
            [visualEffectView, blurLabelView].forEach {
                if tagReviewRankView.subviews.contains($0) {
                    $0.removeFromSuperview()
                }
            }
        }

        if rankTags.isEmpty {
            [firstRankView, divisionLine, otherClassStackView].forEach { $0.isHidden = true }
            return
        } else if let first = rankTags.first {
            firstRankView.setUpContents(tag: first.tag)
        }

        rankTags.prefix(4)
            .adjacentPairs()
            .forEach { prev, next in
                if prev.voteCount > next.voteCount { rank += 1 }
                let other = OtherRankView()
                other.setUpContents(tag: next.tag, rank: rank)
                otherClassStackView.addArrangedSubview(other)
            }
    }

    private func makeBlurPlaceholder(reviewInfoCase: ReviewInfoCase) {
        let labelText = reviewInfoCase.text
        greaterThanTenLabel.setText(text: labelText, font: .bodyMediumOverTwoLine)
        greaterThanTenLabel.textAlignment = .center

        blurLabelView.addSubview(greaterThanTenLabel)

        [visualEffectView, blurLabelView].forEach { tagReviewRankView.addSubview($0) }
        visualEffectView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        blurLabelView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(53)
        }

        greaterThanTenLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func layout() {
        [registerReviewView, tagVoteCountView, tagReviewRankView, reviewCountView].forEach {
            contentView.addSubview($0)
        }

        registerReviewView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        tagVoteCountView.snp.makeConstraints {
            $0.top.equalTo(registerReviewView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        tagReviewRankView.snp.makeConstraints {
            $0.top.equalTo(tagVoteCountView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        reviewCountView.snp.makeConstraints {
            $0.top.equalTo(tagReviewRankView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    private func addMoveToRegisterReviewAction() {
        moveToRegisterReviewButton.addAction(UIAction { _ in
            self.moveToRegisterReview?()
        }, for: .touchUpInside)
    }
}

extension ReviewInfoCell {
    enum ReviewInfoCase {
        case noReviews
        case noTagReviews
        case underTenReviews

        var text: String {
            switch self {
            case .noReviews:
                return "리뷰 쓰기에 참여해서\n이 매장의 좋은점을 알려주세요!"
            case .noTagReviews:
                return "아직 참여자가 충분하지 않아\n이 매장의 좋은점을 볼 수 없어요"
            case .underTenReviews:
                return "10명 이상 참여하면\n공개됩니다!"
            }
        }
    }
}
