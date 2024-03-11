//
//  LectureHistoryViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine

protocol LectureHistoryViewModel: ObservableObject {
    var history: Dictionary<String, [Lecture]>? { get set }
    var sortedHistoryKeys: [String]? { get }
    
    func fetchHistory()
}

extension LectureHistoryViewModel {
    var sortedHistoryKeys: [String]? {
        if let history {
            return history.keys.sorted { $0 < $1 }
        } else {
            return nil
        }
    }
}

final class DefaultLectureHistoryViewModel {
    @Published var history: Dictionary<String, [Lecture]>?
    
    private let usecase: GetLectureHistoryUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetLectureHistoryUseCase) {
        self.usecase = usecase
    }
}

extension DefaultLectureHistoryViewModel: LectureHistoryViewModel {
    func fetchHistory() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched lecture history")
                case .failure(let error):
                    print("DefaultLectureHistoryViewModel.fetchHistory() error: ", error)
                }
            }, receiveValue: { [weak self] history in
                self?.history = history
            })
            .store(in: &cancellables)
    }
}
