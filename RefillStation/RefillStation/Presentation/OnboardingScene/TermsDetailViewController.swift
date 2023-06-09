//
//  TermsDetailViewController.swift
//  RefillStation
//
//  Created by kong on 2023/01/29.
//

import UIKit
import SnapKit

final class TermsDetailViewController: UIViewController {
    private let termsType: TermsType
    private lazy var termsTextView: UITextView = {
        let textView = UITextView()
        textView.text = self.termsType.content
        textView.font = .font(style: .bodySmall)
        textView.textColor = Asset.Colors.gray5.color
        textView.showsVerticalScrollIndicator = false
        textView.isEditable = false
        textView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textView
    }()

    init(termsType: TermsType) {
        self.termsType = termsType
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        moveToTop()
    }

    override func viewWillAppear(_ animated: Bool) {
        setUpNavigationBar()
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
        tabBarController?.tabBar.isHidden = false
    }

    private func layout() {
        view.addSubview(termsTextView)
        termsTextView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view)
        }
    }

    private func moveToTop() {
        let contentHeight = termsTextView.contentSize.height
        let offSet = termsTextView.contentOffset.x
        let contentOffset = contentHeight - offSet
        termsTextView.contentOffset = CGPoint(x: 0, y: -contentOffset)
    }

    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = Asset.Colors.gray7.color
        self.title = termsType.title
    }
}
