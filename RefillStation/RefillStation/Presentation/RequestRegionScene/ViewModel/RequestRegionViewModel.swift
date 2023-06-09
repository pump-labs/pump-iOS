//
//  RequestRegionViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/12/03.
//

import Foundation

final class RequestRegionViewModel {

    private let customerSatisfactionUseCase: CustomerSatisfactionUseCaseInterface
    private var requestRegionTask: Cancellable?
    var requestCompleted: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    init(customerSatisfactionUseCase: CustomerSatisfactionUseCaseInterface = CustomerSatisfactionUseCase()) {
        self.customerSatisfactionUseCase = customerSatisfactionUseCase
    }

    func requestButtonTapped(text: String) {
        requestRegionTask = Task {
            do {
                try await customerSatisfactionUseCase.execute(
                    requestValue: .init(userId: 0, content: text, type: .requestRegion)
                )
                requestCompleted?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }
}

extension RequestRegionViewModel {
    func viewWillDisappear() {
        requestRegionTask?.cancel()
    }
}
