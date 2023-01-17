//
//  ProductCategoriesCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

struct ProductCategoriesCellInfo: Hashable {
    let categories: [ProductCategory]
    let currentFilter: ProductCategory
    let filteredCount: Int
}

final class ProductCategoriesCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoriesCell"

    private(set) var categories: [ProductCategory]?
    private let indexPathForAll = IndexPath(row: 0, section: 0)

    private let productsCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray4.color
        return label
    }()

    private lazy var categoryCollectionView: UICollectionView = {
        let layout = categoryCollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    private lazy var categoryCollectionDataSource = diffableDataSource()

    var categoryButtonTapped: ((ProductCategory?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCategoryCollectionView()
        layout()
        applyDataSource()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(info: ProductCategoriesCellInfo) {
        productsCountLabel.text = "판매상품 \(info.filteredCount)건"
        self.categories = [ProductCategory.all] + info.categories
        applyDataSource()
        if let indexPathToSelect = self.categories?.firstIndex(of: info.currentFilter) {
            categoryCollectionView.selectItem(at: IndexPath(row: indexPathToSelect, section: 0),
                                              animated: false, scrollPosition: .centeredHorizontally)
        }
        layoutIfNeeded()
    }

    private func setUpCategoryCollectionView() {
        categoryCollectionView.register(ProductCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier)
        categoryCollectionView.dataSource = categoryCollectionDataSource
        categoryCollectionView.delegate = self
        categoryCollectionView.showsVerticalScrollIndicator = false
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.isScrollEnabled = false
    }

    private func layout() {
        [categoryCollectionView, productsCountLabel].forEach {
            contentView.addSubview($0)
        }

        categoryCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(35)
        }

        productsCountLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
        }
    }

    private func categoryCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .estimated(35)))
        item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(0), trailing: .fixed(0), bottom: .fixed(0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 8, bottom: 0, trailing: 0)
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension ProductCategoriesCell {
    enum Section {
        case main
    }

    private func diffableDataSource() -> UICollectionViewDiffableDataSource<Section, ProductCategory> {
        return UICollectionViewDiffableDataSource<Section, ProductCategory>(collectionView: categoryCollectionView) { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProductCategoryCollectionViewCell.reuseIdentifier,
                for: indexPath) as? ProductCategoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setUpContents(category: itemIdentifier)
            return cell
        }
    }

    private func applyDataSource() {
        guard let categories = categories else { return }
        var snapShot = NSDiffableDataSourceSnapshot<Section, ProductCategory>()
        snapShot.appendSections([.main])
        snapShot.appendItems(categories, toSection: .main)
        categoryCollectionDataSource.apply(snapShot)
    }
}

extension ProductCategoriesCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let categories = categories else { return }
        categoryButtonTapped?(categories[indexPath.row])
    }
}
