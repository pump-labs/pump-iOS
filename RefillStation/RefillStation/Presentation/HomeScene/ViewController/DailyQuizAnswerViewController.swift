//
//  DailyQuizResultAnswerViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import UIKit

final class DailyQuizAnswerViewController: StackScrollViewController {

    var coordinator: HomeCoordinator?
    private let viewModel: DailyQuizAnswerViewModel

    private let cardImageView: UIView = {
        let cardImageView = UIView()
        return cardImageView
    }()

    private let cardTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let cardDescriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private lazy var cardView: UIView = {
        let cardView = UIView()
        [cardImageView, cardTitleLabel, cardDescriptionLabel].forEach {
            cardView.addSubview($0)
        }
        return cardView
    }()

    private lazy var cardOuterView: UIView = {
        let backgroundView = UIView()
        backgroundView.addSubview(cardView)
        return backgroundView
    }()

    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("공유하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    private lazy var saveToAlbumButton: UIButton = {
        let button = UIButton()
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStackView()
        layout()
    }

    init(viewModel: DailyQuizAnswerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpNavigationBar() {
        let appearance = AppDelegate.transparentNavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }

    private func setUpStackView() {
        stackView.axis = .vertical
        stackView.spacing = 10
    }

    private func layout() {
        // TODO: 임시 코드 삭제
        cardOuterView.snp.makeConstraints {
            $0.height.equalTo(500)
        }
        cardOuterView.backgroundColor = .yellow
        [cardOuterView, shareButton, saveToAlbumButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
}
