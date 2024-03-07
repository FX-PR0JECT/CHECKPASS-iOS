//
//  EnrollmentHistoryViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine

protocol EnrollmentHistoryViewModel: ObservableObject {
    var history: Dictionary<String, [SimpleLecture]>? { get set }
    var sortedHistoryKeys: [String]? { get }
    
    func fetchHistory()
}

extension EnrollmentHistoryViewModel {
    var sortedHistoryKeys: [String]? {
        if let history {
            return history.keys.sorted { $0 < $1 }
        } else {
            return nil
        }
    }
}

final class DefaultEnrollmentHistoryViewModel {
    @Published var history: Dictionary<String, [SimpleLecture]>?
    
    private let usecase: GetEnrollmentHistoryUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetEnrollmentHistoryUseCase) {
        self.usecase = usecase
    }
}

extension DefaultEnrollmentHistoryViewModel: EnrollmentHistoryViewModel {
    func fetchHistory() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched lecture history")
                case .failure(let error):
                    print("DefaultEnrollmentHistoryViewModel.fetchHistory() error: ", error)
                }
            }, receiveValue: { [weak self] history in
                self?.history = history
            })
            .store(in: &cancellables)
    }
}
