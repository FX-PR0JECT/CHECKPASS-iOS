//
//  EAttendanceViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/29/24.
//

import Combine

protocol EAttendanceViewModel: ObservableObject {
    var lectures: Array<SimpleLecture>? { get set }
    
    func getCurrentLectures()
}

final class DefaultEAttendanceViewModel {
    @Published var lectures: [SimpleLecture]?
    
    let usecase: GetCurrentUserLectureUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetCurrentUserLectureUseCase) {
        self.usecase = usecase
    }
}

extension DefaultEAttendanceViewModel: EAttendanceViewModel {
    func getCurrentLectures() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched current lectures")
                case .failure(let error):
                    print("DefaultEAttendanceViewModel.getCurrentLectures() error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.lectures = $0
            })
            .store(in: &cancellables)
    }
}
