//
//  RecentlyEnrolledLectureViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/29/24.
//

import Combine

protocol RecentlyEnrolledLectureViewModel: ObservableObject {
    var lectures: Array<Lecture>? { get set }
    
    func getLectures()
}

final class DefaultRecentlyEnrolledLectureViewModel {
    @Published var lectures: [Lecture]?
    
    let usecase: GetRecentlyEnrolledLectureUseCase
    var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetRecentlyEnrolledLectureUseCase) {
        self.usecase = usecase
    }
}

extension DefaultRecentlyEnrolledLectureViewModel: RecentlyEnrolledLectureViewModel {
    func getLectures() {
        usecase.execute()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched current lectures")
                case .failure(let error):
                    print("DefaultRecentlyEnrolledLectureViewModel.getLectures() error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.lectures = $0
            })
            .store(in: &cancellables)
    }
}
