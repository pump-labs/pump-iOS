//
//  StoreDetailCoordinator.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/19.
//

import UIKit

final class StoreDetailCoordinator: Coordinator {
    let DIContainer: StoreDetailDIContainer
    private let navigationController: UINavigationController

    init(DIContainer: StoreDetailDIContainer, navigationController: UINavigationController) {
        self.DIContainer = DIContainer
        self.navigationController = navigationController
    }

    func start() {
        let storeDetailViewController = DIContainer.makeStoreDetailViewController()
        storeDetailViewController.coordinator = self
        navigationController.pushViewController(storeDetailViewController, animated: true)
    }

    func showRegisterReview() {
        let registerReviewDIContainer = DIContainer.makeRegisterReviewDIContainer()
        let registerReviewCoordinator = registerReviewDIContainer.makeRegisterReviewCoordinator()
        registerReviewCoordinator.start()
    }

    func showDetailPhotoReview(photoURLs: [String?]) {
        let detailPhotoReviewViewController = DIContainer.makeDetailPhotoReviewViewController(photoURLs: photoURLs)
        detailPhotoReviewViewController.coodinator = self
        navigationController.pushViewController(detailPhotoReviewViewController, animated: true)
    }

    func popPhotoDetail() {
        navigationController.popViewController(animated: true)
    }

    func showLogin() {
        let onboardingDIContainer = DIContainer.makeOnboardingDIContainer()
        let onboardingCoordinator = onboardingDIContainer.makeOnboardingCoordinator()
        onboardingCoordinator.showLogin(viewType: .lookAround)
    }
}
