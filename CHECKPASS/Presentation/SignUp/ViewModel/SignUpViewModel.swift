//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine
import SwiftUI

enum InputState {
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
    @Published var signUpResult: Bool?    //Sign up Response result (true or false)
    @Published var isAlertVisible: Bool = false
    @Published var alertType: AlertType = .signUpSucceed
    
    private let signUpUseCase: SignUpUseCase
    private let idDuplicationCheckUseCase: IdDuplicationCheckUseCase
    private var cancellables = Set<AnyCancellable>()
    private var isRequestPossible: Bool = true    //id duplication check flag variable
    
    init(signUpUseCase: SignUpUseCase, idDuplicationCheckUseCase: IdDuplicationCheckUseCase) {
        self.signUpUseCase = signUpUseCase
        self.idDuplicationCheckUseCase = idDuplicationCheckUseCase
    }
}

extension SignUpViewModel: SignUpVM {
    //MARK: - check input id duplication
    func executeIdDuplicationCheck(for id: String) {
        guard !id.isEmpty else {    //id is empty
            withAnimation {
                defaultStates["id"] = .isBlank
            }
            isRequestPossible = false
            return
        }
        
        isRequestPossible = true
            
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) { [weak self] in
            self?.idDuplicationCheckUseCase.execute(id)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        print("successfully checked ID duplication")
                    case .failure(let error):
                        print("SignUpViewModel.executeIdDuplicationConfirm(for:) error", error)
                    }
                }, receiveValue: { authResult in
                    if self?.isRequestPossible == true {
                        withAnimation {
                            self?.defaultStates["id"] = authResult.result ? .isValid : .isInvalid
                        }
                    }
                })
                .store(in: &self!.cancellables)
        }
    }
    
    //MARK: - register for Student
    func executeStudentRegister(id: String, pw: String, name: String, job: String, collage: String,
                                department: String, grade: String, dayOrNight: String, semester: String) {
        let data = [
            "signUpId": id, "signUpPassword": pw, "signUpName": name,
            "signUpJob": job, "signUpCollege": collage, "signUpDepartment": department,
            "signUpGrade": grade, "signUpDayOrNight": dayOrNight, "signUpSemester": semester
        ]
        
        signUpUseCase.executeForStudent(data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully registered User Data")
                case .failure(let error):
                    print("SignUpViewModel.executeStudentRegister(id:pw:name:job:collage:department:grade:dayOrNight:semester:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.isAlertVisible = true
                
                if $0.result {    //Sign up successful
                    self?.alertType = .signUpSucceed
                    self?.signUpResult = true
                } else {    //Sign up failed
                    self?.alertType = .signUpFailed
                    self?.signUpResult = false
                }
            })
            .store(in: &cancellables)
    }
    
    //MARK: - register for Staff & Professor
    func executeStaffRegister(id: String, pw: String, name: String, job: String, collage: String, department: String, hireDate: String) {
        let data = [
            "signUpId": id, "signUpPassword": pw, "signUpName": name, "signUpJob": job,
            "signUpCollege": collage, "signUpDepartment": department, "signUpHireDate": hireDate
        ]
        
        signUpUseCase.executeForStaff(data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully registered User Data")
                case .failure(let error):
                    print("SignUpViewModel.executeStaffRegister(id:pw:name:type:collage:department:) error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.isAlertVisible = true
                
                if $0.result {    //Sign up Success
                    self?.alertType = .signUpSucceed
                    self?.signUpResult = true
                } else {    //Sign up failed
                    self?.alertType = .signUpFailed
                    self?.signUpResult = false
                }
            })
            .store(in: &cancellables)
    }
}
