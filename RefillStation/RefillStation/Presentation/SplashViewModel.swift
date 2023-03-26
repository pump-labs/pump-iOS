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
        Task {
            if await isServerAlive() {
                startOnboardingFlow?()
            } else {
                startHomeFlow?()
            }
        }
    }

    private func isServerAlive() async -> Bool {
        return true
    }
}
