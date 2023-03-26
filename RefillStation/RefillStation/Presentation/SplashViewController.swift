//
//  SplashViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/26.
//

import UIKit
import SnapKit

final class SplashViewController: UIViewController {

    var cooridnator: SplashCoordinator?
    private let viewModel: SplashViewModel
    private let splashImageView = UIImageView(image: Asset.Images.iconPump.image)

    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }

    private func bind() {
        viewModel.startHomeFlow = { [weak self] in
            DispatchQueue.main.async {
                self?.cooridnator?.startHome()
            }
        }
        viewModel.startOnboardingFlow = { [weak self] in
            DispatchQueue.main.async {
                self?.cooridnator?.startOnboarding()
            }
        }
    }

    private func layout() {
        view.addSubview(splashImageView)
        splashImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
