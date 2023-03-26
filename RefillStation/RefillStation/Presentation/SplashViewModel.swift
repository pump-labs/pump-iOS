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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            Task {
                if await self.isServerAlive() {
                    self.startOnboardingFlow?()
                } else {
                    self.startHomeFlow?()
                }
            }
        }
    }

    private func isServerAlive() async -> Bool {
        return true
    }
}
