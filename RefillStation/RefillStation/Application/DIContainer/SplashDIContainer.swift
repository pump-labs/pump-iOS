//
//  SplashDIContainer.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/26.
//

import UIKit

final class SplashDIContainer: DIContainer {

    func makeSplashCoordinator() -> SplashCoordinator {
        return SplashCoordinator(DIContainer: self)
    }

    func makeOnboardingCoordinator() -> OnboardingCoordinator {
        let DIContainer = OnboardingDIContainer()
        return DIContainer.makeOnboardingCoordinator()
    }

    func makeTabBarCooridnator() -> TabBarCoordinator {
        let DIContainer = TabBarDIContainer()
        return DIContainer.makeTabBarCoordinator()
    }

    func makeSplashViewModel() -> SplashViewModel {
        return SplashViewModel()
    }

    func makeSplashViewController() -> SplashViewController {
        return SplashViewController(viewModel: makeSplashViewModel())
    }
}
