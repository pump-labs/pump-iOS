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
    var showErrorAlert: ((_ title: String, _ description: String) -> Void)?

    func startFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            Task {
                if await !self.isServerAlive() {
                    self.showErrorAlert?("서버 에러", "현재 서버가 열려있지 않아요 😢")
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
