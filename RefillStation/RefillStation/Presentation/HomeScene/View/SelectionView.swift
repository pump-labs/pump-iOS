//
//  SelectionView.swift
//  RefillStation
//
//  Created by 천수현 on 2023/07/14.
//

import UIKit

final class SelectionView: UIView {
    var selectionState: SelectionState = .unselected {
        didSet { applySelectionState() }
    }

    private let selectionTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    init(selectionText: String) {
        super.init(frame: .zero)
        selectionTextLabel.text = selectionText
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func layout() {
        addSubview(selectionTextLabel)
        selectionTextLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func applySelectionState() {
        layer.borderColor = selectionState.color.cgColor
    }
}

extension SelectionView {
    enum SelectionState {
        case selected
        case unselected
        case wrong

        var color: UIColor {
            switch self {
            case .selected:
                return Asset.Colors.gray7.color
            case .unselected:
                return Asset.Colors.gray1.color
            case .wrong:
                return Asset.Colors.error.color
            }
        }
    }
}
