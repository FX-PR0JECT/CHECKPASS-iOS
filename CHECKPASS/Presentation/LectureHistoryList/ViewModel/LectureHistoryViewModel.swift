//
//  LectureHistoryViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine
import Foundation

protocol LectureHistoryViewModel: ObservableObject {
    var history: Dictionary<String, [Lecture]>? { get set }
    var sortedHistoryKeys: [String]? { get }
    var isProgress: Bool { get set }
    var isFirstAppear: Bool { get set }
    
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
    @Published var isProgress: Bool = false
    @Published var isFirstAppear: Bool = true
    
    private let usecase: GetLectureHistoryUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetLectureHistoryUseCase) {
        self.usecase = usecase
    }
}

extension DefaultLectureHistoryViewModel: LectureHistoryViewModel {
    func fetchHistory() {
        isProgress.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            self.usecase.execute()
                .sink(receiveCompletion: { [weak self] completion in
                    self?.isProgress.toggle()
                    if let isFirstAppear = self?.isFirstAppear, isFirstAppear {
                        self?.isFirstAppear.toggle()
                    }
                    
                    switch completion {
                    case .finished:
                        print("successfully fetched lecture history")
                    case .failure(let error):
                        print("DefaultLectureHistoryViewModel.fetchHistory() error: ", error)
                    }
                }, receiveValue: { [weak self] history in
                    self?.history = history
                })
                .store(in: &self.cancellables)
        })
        
//        usecase.execute()
//            .sink(receiveCompletion: { [weak self] completion in
//                self?.isProgress.toggle()
//                if let isFirstAppear = self?.isFirstAppear, isFirstAppear {
//                    self?.isFirstAppear.toggle()
//                }
//                
//                switch completion {
//                case .finished:
//                    print("successfully fetched lecture history")
//                case .failure(let error):
//                    print("DefaultLectureHistoryViewModel.fetchHistory() error: ", error)
//                }
//            }, receiveValue: { [weak self] history in
//                self?.history = history
//            })
//            .store(in: &cancellables)
    }
}
