//
//  DailyQuizViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import UIKit

final class DailyQuizViewController: UIViewController {

    var coordinator: HomeCoordinator?
    private let viewModel: DailyQuizViewModel

    private let outerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()

    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.spacing = 20
        return stackView
    }()

    private let quizLabel: UILabel = {
        let label = UILabel()
        label.applyFont(font: .titleLarge1)
        return label
    }()

    private lazy var hintButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("힌트보기", for: .normal)
        button.backgroundColor = Asset.Colors.gray4.color
        button.setTitleColor(.white, for: .normal)
        button.addAction(UIAction { [weak self] _ in
//            self.
        }, for: .touchUpInside)
        return button
    }()

    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.setTitle("제출하기", for: .normal)
        button.backgroundColor = Asset.Colors.primary9.color
        button.setTitleColor(.white, for: .normal)
        button.addAction(UIAction { [weak self] _ in
//            self.
        }, for: .touchUpInside)
        return button
    }()

    init(viewModel: DailyQuizViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpNavigationBar()
        layout()
        bind()
        viewModel.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisappear()
    }

    private func setUpNavigationBar() {
        let appearance = AppDelegate.transparentNavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }

    private func bind() {
        viewModel.applyDailyQuiz = { [weak self] quiz in
            DispatchQueue.main.async {
                guard let self else { return }
                self.quizLabel.text = quiz.quiz
                let selections = quiz.selections.map {
                    SelectionView(selectionText: $0.text)
                }

                selections.forEach {
                    self.outerStackView.addArrangedSubview($0)
                }
                [self.hintButton, self.submitButton].forEach {
                    self.outerStackView.addArrangedSubview($0)
                    $0.snp.makeConstraints {
                        $0.height.equalTo(50)
                    }
                }
            }
        }
    }

    private func layout() {
        view.addSubview(outerScrollView)
        outerScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        outerScrollView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view).inset(30)
            $0.top.bottom.equalToSuperview().inset(30)
        }
        outerStackView.addArrangedSubview(quizLabel)
    }
}
