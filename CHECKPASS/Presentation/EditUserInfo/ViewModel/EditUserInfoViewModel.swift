//
//  EditUserInfoViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import Combine

final class EditUserInfoViewModel {
    @Published var defaultStates: Dictionary<String, InputState> = ["name": .isInitial, "department": .isInitial]
    @Published var studentStates: Dictionary<String, InputState> = ["grade": .isInitial, "dayOrNight": .isInitial, "semesters": .isInitial]
    @Published var staffStates: Dictionary<String, InputState> = ["hireDate": .isInitial]
    @Published var isAlertVisible: Bool = false
    @Published var alertType: AlertType = .signUpSucceed
    @Published var departments: Departments?
    
    private let getDepartmentsUseCase: GetDepartmentsUseCase
    private var cancellables = Set<AnyCancellable>()
    internal var colleges: Colleges?
    
    init(getDepartmentUseCase: GetDepartmentsUseCase) {
        self.getDepartmentsUseCase = getDepartmentUseCase
    }
}

extension EditUserInfoViewModel: UserInfoInputVM {
    func getDepartmentsData(of college: String) {
        getDepartmentsUseCase.executeForDeparments(college: college)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched departments")
                case .failure(let error):
                    print("EditUserInfoViewModel.getDepartmentsData(of:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.departments = $0
            })
            .store(in: &cancellables)
    }
}
