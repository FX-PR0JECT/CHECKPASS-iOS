//
//  EditUserInfoViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import Combine
import Foundation

protocol EditUserInfoVM {
    var isChanged: Bool { get }
    
    func executeForStudent(updateName: String, updateDepartment: String, updateStudentGrade: String, updateDayOrNight: String, updateStudentSemester: String)
    func executeForStaff(updateName: String, updateDepartment: String, updateHireDate: String)
    func compare(_ lhs: User?, _ rhs: User?)
}

final class EditUserInfoViewModel {
    @Published var defaultStates: Dictionary<String, InputState> = ["name": .isInitial, "department": .isInitial]
    @Published var studentStates: Dictionary<String, InputState> = ["grade": .isInitial, "dayOrNight": .isInitial, "semesters": .isInitial]
    @Published var staffStates: Dictionary<String, InputState> = ["hireDate": .isInitial]
    @Published var isAlertVisible: Bool = false
    @Published var alertType: AlertType = .requestSucceed
    @Published var departments: Departments?
    @Published var isChanged: Bool = false
    
    private let getDepartmentsUseCase: GetDepartmentsUseCase
    private let editUserInfoUseCase: EditUserInfoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(getDepartmentUseCase: GetDepartmentsUseCase, editUserInfoUseCase: EditUserInfoUseCase) {
        self.getDepartmentsUseCase = getDepartmentUseCase
        self.editUserInfoUseCase = editUserInfoUseCase
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

extension EditUserInfoViewModel: EditUserInfoVM {
    func compare(_ lhs: User?, _ rhs: User?) {
        if let lhs = lhs as? DetailedStudentInfo, let rhs = rhs as? DetailedStudentInfo {
            isChanged = lhs == rhs ? false : true
        } else if let lhs = lhs as? DetailedStaffInfo, let rhs = rhs as? DetailedStaffInfo {
            if lhs == rhs {
                isChanged = lhs == rhs ? false : true
            }
        }
    }
    
    func executeForStudent(updateName: String, updateDepartment: String, updateStudentGrade: String, updateDayOrNight: String, updateStudentSemester: String) {
        guard let updateDepartment = departments?[updateDepartment] else {
            alertType = .requestFailed
            isAlertVisible = true
            return
        }
        
        let data = ["updateName": updateName, "updateDepartment": updateDepartment,
                    "updateStudentGrade": updateStudentGrade, "updateDayOrNight": updateDayOrNight,
                    "updateStudentSemester": updateStudentSemester]
        
        editUserInfoUseCase.execute(data: data, type: .student)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("successfully update student information")
                case .failure(let error):
                    self?.alertType = .requestFailed
                    self?.isAlertVisible = true
                    
                    print("EditUserInfoViewModel. executeForStudent(updateName:updateDepartment:updateStudentGrade:updateDayOrNight:updateStudentSemester:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                if $0.result {
                    self?.alertType = .requestSucceed
                } else{
                    self?.alertType = .requestFailed
                }
                
                self?.isAlertVisible = true
            })
            .store(in: &cancellables)
    }
    
    func executeForStaff(updateName: String, updateDepartment: String, updateHireDate: String) {
        guard let updateDepartment = departments?[updateDepartment] else {
            alertType = .requestFailed
            isAlertVisible = true
            return
        }
        
        let data = ["updateName": updateName, "updateDepartment": updateDepartment,
                    "updateHireDate": updateHireDate]
        
        editUserInfoUseCase.execute(data: data, type: .staff)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("successfully update staff information")
                case .failure(let error):
                    self?.alertType = .requestFailed
                    self?.isAlertVisible = true
                    
                    print("EditUserInfoViewModel.executeForStaff(updateName:updateDepartment:updateHireDate:) error:", error)
                }
            }, receiveValue: { [weak self] in
                if $0.result {
                    self?.alertType = .requestSucceed
                } else{
                    self?.alertType = .requestFailed
                }
                
                self?.isAlertVisible = true
            })
            .store(in: &cancellables)
    }
}
