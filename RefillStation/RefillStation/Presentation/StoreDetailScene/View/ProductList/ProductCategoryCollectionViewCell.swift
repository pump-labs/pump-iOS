//
//  ProductCategoryCollectionViewCell.swift
//  RefillStation
//
//  Created by 천수현 on 2022/12/31.
//

import UIKit

final class ProductCategoryCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "productCategoryCollectionViewCell"

    private var category: ProductCategory?

    override var isSelected: Bool {
        didSet {
            isSelected ? setUpSelected() : setUpDeselected()
        }
    }

    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.gray4.color
        label.font = UIFont.font(style: .buttonMedium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        layout()
        setUpDeselected()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents(category: ProductCategory) {
        self.category = category
        categoryLabel.setText(text: category.title, font: .buttonMedium)
    }

    private func layout() {
        contentView.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }

    private func setUpDeselected() {
        contentView.backgroundColor = .white
        layer.cornerRadius = 16
        layer.borderColor = Asset.Colors.gray2.color.cgColor
        categoryLabel.textColor = Asset.Colors.gray4.color
        layer.borderWidth = 1
        clipsToBounds = true
    }

    private func setUpSelected() {
        contentView.backgroundColor = Asset.Colors.primary1.color
        layer.cornerRadius = 16
        layer.borderColor = Asset.Colors.primary8.color.cgColor
        layer.borderWidth = 1
        categoryLabel.textColor = Asset.Colors.primary10.color
        clipsToBounds = true
    }
}
