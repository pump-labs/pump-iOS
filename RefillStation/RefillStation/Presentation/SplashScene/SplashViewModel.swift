//
//  SplashViewModel.swift
//  RefillStation
//
//  Created by 천수현 on 2023/03/26.
//

import Foundation

final class SplashViewModel {

    var startOnboardingFlow: (() -> Void)?
    var startHomeFlow: (() -> Void)?

    func startFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            Task {
                if await !self.isServerAlive() {
                    // show error alert
                } else if self.didLoginSuccessed() {
                    self.startHomeFlow?()
                } else {
                    self.startOnboardingFlow?()
                }
            }
        }
    }

    private func isServerAlive() async -> Bool {
        return true
    }

    private func didLoginSuccessed() -> Bool {
        return KeychainManager.shared.getItem(key: "token") != nil
            || KeychainManager.shared.getItem(key: "lookAroundToken") != nil
    }
}
