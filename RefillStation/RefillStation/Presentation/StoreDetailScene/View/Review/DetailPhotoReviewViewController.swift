//
//  DetailPhotoReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/17.
//

import UIKit

final class DetailPhotoReviewViewController: UIViewController {

    var coodinator: StoreDetailCoordinator?
    private let viewModel: DetailPhotoReviewViewModel

    private lazy var orthogonalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()

    private let photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .black
        return stackView
    }()

    private lazy var moveLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0.2)
        button.tintColor = .white
        button.isHidden = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.page > 0 {
                self.viewModel.page -= 1
                self.scrollToCurrentPage()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var moveRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0.2)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            if self.viewModel.page < self.viewModel.photoURLs.count - 1 {
                self.viewModel.page += 1
                self.scrollToCurrentPage()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addAction(UIAction { [weak self] _ in
            self?.coodinator?.popPhotoDetail()
        }, for: .touchUpInside)
        return button
    }()

    private lazy var pageCountLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "1 / ", font: .bodyMedium)
        label.textColor = .white
        return label
    }()

    private lazy var maxPageCountLabel: UILabel = {
        let label = UILabel()
        label.setText(text: "\(viewModel.photoURLs.count)", font: .bodyMedium)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    init(viewModel: DetailPhotoReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = DetailPhotoReviewViewModel(photoURLs: [])
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        bind()
        layout()
        addPhotosToStackView()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = false
    }

    private func bind() {
        viewModel.setUpPageLabel = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.pageCountLabel.setText(text: "\(self.viewModel.page + 1) / ", font: .bodyMedium)
            }
        }
    }

    private func layout() {
        [orthogonalScrollView, moveLeftButton, moveRightButton, backButton, maxPageCountLabel, pageCountLabel].forEach {
            view.addSubview($0)
        }

        orthogonalScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        moveLeftButton.snp.makeConstraints {
            $0.leading.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(44)
        }

        moveRightButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(44)
        }

        backButton.snp.makeConstraints {
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(9)
            $0.height.width.equalTo(24)
        }

        maxPageCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.centerY.equalTo(backButton)
        }
        pageCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(maxPageCountLabel.snp.leading)
            $0.centerY.equalTo(backButton)
        }

        orthogonalScrollView.addSubview(photoStackView)

        photoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(backButton.snp.bottom)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        if viewModel.photoURLs.count == 1 {
            moveRightButton.isHidden = true
        }
    }

    private func addPhotosToStackView() {
        viewModel.photoURLs.forEach { imagePath in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .black
            imageView.kf.setImage(with: URL(string: imagePath ?? ""))
            photoStackView.addArrangedSubview(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(view)
                $0.top.bottom.equalToSuperview()
            }
        }
    }

    private func scrollToCurrentPage() {
        self.orthogonalScrollView.setContentOffset(
            CGPoint(x: self.orthogonalScrollView.frame.width * CGFloat(self.viewModel.page),
                    y: self.orthogonalScrollView.contentOffset.y),
            animated: true)
    }
}

extension DetailPhotoReviewViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if orthogonalScrollView.frame.width == 0 { return }
        let page = orthogonalScrollView.contentOffset.x / orthogonalScrollView.frame.width
        let flooredPage = floor(page)
        if flooredPage != page { return }

        if viewModel.page != Int(page)
            && (0...viewModel.photoURLs.count - 1) ~= Int(page) { viewModel.page = Int(page) }
        if viewModel.page == 0 {
            moveLeftButton.isHidden = true
            moveRightButton.isHidden = false
        } else if viewModel.page == viewModel.photoURLs.count - 1 {
            moveLeftButton.isHidden = false
            moveRightButton.isHidden = true
        } else {
            moveLeftButton.isHidden = false
            moveRightButton.isHidden = false
        }
    }
}
