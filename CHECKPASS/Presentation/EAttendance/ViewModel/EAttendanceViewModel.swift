//
//  EAttendanceViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/18/24.
//

import Combine

protocol EAttendanceViewModel {
    var input: String { get set }
    
    func verifyInput(_ input: String)
    func executeForEAttendance()
}

final class DefaultEAttendanceViewModel: AttendanceViewModel {
    @Published var input: String = ""
    @Published var result: Bool?
    @Published var resultSet = ""
    @Published var isProgress = false
    
    private let usecase: AttendanceUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: AttendanceUseCase) {
        self.usecase = usecase
    }
}

extension DefaultEAttendanceViewModel: EAttendanceViewModel {
    func executeForEAttendance() {
        isProgress = true
        usecase.executeForEAttendance(attendanceCode: input)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isProgress = false
                
                switch completion {
                case .finished:
                    print("API response success")
                case .failure(let error):
                    print("DefaultAttendanceViewModel.executeForEAttendance error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.result = $0.result
                self?.resultSet = $0.resultSet
            })
            .store(in: &cancellables)
    }
    
    func verifyInput(_ input: String) {
        if input.count > 4 {
            let start = input.startIndex
            let end = input.index(start, offsetBy: 3)
            self.input = String(input[start...end])
        }
    }
}
