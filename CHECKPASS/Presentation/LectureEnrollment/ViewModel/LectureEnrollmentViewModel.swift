//
//  LectureEnrollmentViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/28/24.
//

import Combine

enum LectureEnrollmentAlertType {
    case success
    case failure
    case excess
    case noPermission
}

protocol LectureEnrollmentViewModel: ObservableObject {
    var alertType: LectureEnrollmentAlertType? { get set }
    var alertMessage: String { get set }
    var showAlert: Bool { get set }
    
    func registerLecture(for lectureId: Int)
}

final class DefaultLectureEnrollmentViewModel {
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    @Published var alertType: LectureEnrollmentAlertType?
    
    let usecase: LectureEnrollmentUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(usecase: LectureEnrollmentUseCase) {
        self.usecase = usecase
    }
}

extension DefaultLectureEnrollmentViewModel: LectureEnrollmentViewModel {
    func registerLecture(for lectureId: Int) {
        usecase.execute(lectureId: lectureId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully registered a lecture")
                case .failure(let error):
                    print("DefaultLectureEnrollmentViewModel.registerLecture(for:) error: ", error)
                }
            }, receiveValue: { [weak self] in                
                self?.showAlert.toggle()
                self?.alertMessage = $0.resultSet
            })
            .store(in: &cancellables)
    }
}
