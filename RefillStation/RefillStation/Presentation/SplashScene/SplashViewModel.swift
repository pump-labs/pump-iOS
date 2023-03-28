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
    var showErrorAlert: ((_ title: String?, _ description: String?) -> Void)?

    private let healthCheckUseCase: HealthCheckUseCaseInterface

    init(healthCheckUseCase: HealthCheckUseCaseInterface = HealthCheckUseCase()) {
        self.healthCheckUseCase = healthCheckUseCase
    }

    func startFlow() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            Task {
                if await !self.isServerAlive() {
                    self.showErrorAlert?("Pump는 점검중이에요", "더 좋은 모습으로 찾아올게요! 💪")
                } else if self.didLoginSuccessed() {
                    self.startHomeFlow?()
                } else {
                    self.startOnboardingFlow?()
                }
            }
        }
    }

    private func isServerAlive() async -> Bool {
        do {
            return try await healthCheckUseCase.execute()
        } catch {
            showErrorAlert?(error.localizedDescription, nil)
            return false
        }
    }

    private func didLoginSuccessed() -> Bool {
        return KeychainManager.shared.getItem(key: "token") != nil
            || KeychainManager.shared.getItem(key: "lookAroundToken") != nil
    }
}
