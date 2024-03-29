//
//  AttendanceStatusViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import Combine

protocol AttendanceStatusViewModel: ObservableObject {
    var attendanceStatus: [AttendanceStatuses]? { get set }
    
    func fetchStatus(for lectureId: Int)
}

final class DefaultAttendanceStatusViewModel {
    @Published var attendanceStatus: [AttendanceStatuses]?
    
    private let usecase: GetAttendanceStatusUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: GetAttendanceStatusUseCase) {
        self.usecase = usecase
    }
}

extension DefaultAttendanceStatusViewModel: AttendanceStatusViewModel {
    func fetchStatus(for lectureId: Int) {
        usecase.execute(for: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully request lecture attendance statuses")
                case .failure(let error):
                    print("DefaultAttendanceStatusViewModel.fetchStatus(for:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.attendanceStatus = $0
            })
            .store(in: &cancellables)
    }
}
