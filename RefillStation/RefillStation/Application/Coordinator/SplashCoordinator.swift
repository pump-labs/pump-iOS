//
//  SplashCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/26.
//

import UIKit

final class SplashCoordinator: Coordinator {
    var DIContainer: SplashDIContainer

    init(
        DIContainer: SplashDIContainer
    ) {
        self.DIContainer = DIContainer
    }

    func start() {
        showSplash()
    }

    func showSplash() {
        let splashViewController = DIContainer.makeSplashViewController()
        splashViewController.cooridnator = self
        let window = (UIApplication.shared.delegate as? AppDelegate)?.window
        window?.rootViewController = splashViewController
    }

    func startOnboarding() {
        let coordinator = DIContainer.makeOnboardingCoordinator()
        coordinator.start()
    }

    func startHome() {
        let coordinator = DIContainer.makeTabBarCooridnator()
        coordinator.start()
    }
}
