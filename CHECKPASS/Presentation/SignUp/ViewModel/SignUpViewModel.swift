//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine
import SwiftUI

enum InputState {
    case isNotVerified
    case isInitial
    case isBlank
    case isInvalid
    case isValid
}

enum AlertType {
    case signUpSucceed
    case signUpFailed
    case inValidInput
}

final class SignUpViewModel {
    @Published var defaultStates: Dictionary<String, InputState> = ["id": .isInitial, "pw": .isInitial, "pwConfirmation": .isInitial, "name": .isInitial, "job": .isInitial, "college": .isInitial, "department": .isInitial, "agreement": .isInitial]
    @Published var studentStates: Dictionary<String, InputState> = ["grade": .isInitial, "dayOrNight": .isInitial, "semester": .isInitial]    //only Student Input
    @Published var staffStates: Dictionary<String, InputState> = ["hireDate": .isInitial]    //only Staff Input
    @Published var isAlertVisible: Bool = false
    @Published var alertType: AlertType = .signUpSucceed
    @Published var departments: Departments?
    @Published var colleges: Colleges?
    
    private let signUpUseCase: SignUpUseCase
    private let idDuplicateCheckUseCase: IdDuplicateCheckUseCase
    private let getDepartmentsUseCase: GetDepartmentsUseCase
    private var cancellables = Set<AnyCancellable>()
    private var isRequestPossible: Bool = true    //id duplicate check flag variable
    
    init(signUpUseCase: SignUpUseCase, idDuplicationCheckUseCase: IdDuplicateCheckUseCase, getDepartmentsUseCase: GetDepartmentsUseCase) {
        self.signUpUseCase = signUpUseCase
        self.idDuplicateCheckUseCase = idDuplicationCheckUseCase
        self.getDepartmentsUseCase = getDepartmentsUseCase
    }
}

extension SignUpViewModel: UserInfoInputVM {
    func getCollegesData() {
        getDepartmentsUseCase.executeForColleges()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched colleges data")
                case .failure(let error):
                    print("test_getCollegeData(): ", error)
                }
            }, receiveValue: { [weak self] in
                self?.colleges = $0
            })
            .store(in: &cancellables)
    }
}

extension SignUpViewModel: SignUpVM {
    //MARK: - Check data before staff registration
    func registerForStaff(id: String, pw: String, name: String,
                          job: String, college: String, department: String, hireDate: String) {
        let data = [
            "signUpId": id, "signUpPassword": pw, "signUpName": name, "signUpJob": job,
            "signUpCollege": college, "signUpDepartment": department, "signUpHireDate": hireDate
        ]
        
        //Id is not verified
        guard defaultStates["id"] != .isNotVerified else {
            executeUseCaseAfterCheckingIdDuplicate(for: id, with: data, handler: executeUseCaseForStaff(_:))
            return
        }
        
        //Id is verified
        if verifyStates(for: job) {
            executeUseCaseForStaff(data)
        } else {
            alertType = .inValidInput
            isAlertVisible = true
        }
    }
    
    //MARK: - Check data before student registration
    func registerForStudent(id: String, pw: String, name: String, job: String, college: String,
                            department: String, grade: String, dayOrNight: String, semester: String) {
        let data = [
            "signUpId": id, "signUpPassword": pw, "signUpName": name,
            "signUpJob": job, "signUpCollege": college, "signUpDepartment": department,
            "signUpGrade": grade, "signUpDayOrNight": dayOrNight, "signUpSemester": semester
        ]
        
        //Id is not verified
        guard defaultStates["id"] != .isNotVerified else {
            executeUseCaseAfterCheckingIdDuplicate(for: id, with: data, handler: executeUseCaseForStudent(_:))
            return
        }
        
        //Id is verified
        if verifyStates(for: job) {
            executeUseCaseForStudent(data)
        } else {
            alertType = .inValidInput
            isAlertVisible = true
        }
    }
    
    //MARK: - Register user after checking id duplicate
    func executeUseCaseAfterCheckingIdDuplicate(for id: String,
                                                with data: Dictionary<String, String>,
                                                handler: @escaping (Dictionary<String, String>) -> ()) {
        guard !id.isEmpty else {
            //when id is empty
            withAnimation {
                defaultStates["id"] = .isBlank
            }
            isRequestPossible = false
            alertType = .inValidInput
            isAlertVisible = true
            return
        }
        
        isRequestPossible = true
            
        idDuplicateCheckUseCase.execute(id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully checked Id duplication")
                case .failure(let error):
                    print("SignUpViewModel.registerUserAfterCheckingIdDuplicate(for:data:handler:)", error)
                }
            }, receiveValue: { [weak self] authResult in
                if self?.isRequestPossible == true {
                    withAnimation {
                        self?.defaultStates["id"] = authResult.result ? .isValid : .isInvalid
                    }
                }
                
                if self?.defaultStates["id"] == .isValid &&
                    self?.verifyStates(for: data["signUpJob"]!) == Optional(true) {
                    handler(data)    //All inputs are clear
                } else {
                    //When an invalid value exists
                    self?.alertType = .inValidInput
                    self?.isAlertVisible = true
                }
            })
            .store(in: &self.cancellables)
    }
    
    //MARK: - register for Student
    func executeUseCaseForStudent(_ data: Dictionary<String, String>) {
        signUpUseCase.executeForStudent(data, colleges: colleges, departments: departments)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully completed signup attempt")
                case .failure(let error):
                    print("executeUseCaseForStudent(_:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                if $0.result {    //Sign up complited
                    self?.alertType = .signUpSucceed
                } else {    //Sign up failed
                    self?.alertType = .signUpFailed
                }
                
                self?.isAlertVisible = true
            })
            .store(in: &cancellables)
    }
    
    //MARK: - register for Staff & Professor
    func executeUseCaseForStaff(_ data: Dictionary<String, String>) {
        signUpUseCase.executeForStaff(data, colleges: colleges, departments: departments)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully registered User Data")
                case .failure(let error):
                    print("SignUpViewModel.executeUseCaseForStaff(_:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                if $0.result {    //Sign up Success
                    self?.alertType = .signUpSucceed
                } else {    //Sign up failed
                    self?.alertType = .signUpFailed
                }
                
                self?.isAlertVisible = true
            })
            .store(in: &cancellables)
    }
    
    //MARK: - check input id duplication
    func executeIdDuplicateCheck(for id: String) {
        guard !id.isEmpty else {    //id is empty
            withAnimation {
                defaultStates["id"] = .isBlank
            }
            isRequestPossible = false
            return
        }
        
        isRequestPossible = true
            
        idDuplicateCheckUseCase.execute(id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully checked ID duplication")
                case .failure(let error):
                    print("SignUpViewModel.executeIdDuplicationConfirm(for:) error", error)
                }
            }, receiveValue: { [weak self] authResult in
                if self?.isRequestPossible == true {
                    withAnimation {
                        self?.defaultStates["id"] = authResult.result ? .isValid : .isInvalid
                    }
                }
            })
            .store(in: &self.cancellables)
    }
    
    func getDepartmentsData(of college: String) {
        getDepartmentsUseCase.executeForDeparments(college: college)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched departments data")
                case .failure(let error):
                    print("test_getDepartments(): ", error)
                }
            }, receiveValue: { [weak self] in
                self?.departments = $0
            })
            .store(in: &cancellables)
    }
}
