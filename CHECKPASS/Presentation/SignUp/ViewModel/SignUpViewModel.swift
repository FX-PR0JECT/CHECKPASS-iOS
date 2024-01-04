//
//  SignUpViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Combine

enum InputState {
    case isInitial
    case isBlank
    case isInvalid
    case isValid
}

final class SignUpViewModel {
    @Published var states: Dictionary<String, InputState> = ["id": .isInitial, "pw": .isInitial, "pwConfirmation": .isInitial, "name": .isInitial, "email": .isInitial, "job": .isInitial, "college": .isInitial, "department": .isInitial, "agreement": .isInitial]
    @Published var signUpResult: Bool?    //Sign up Response result (true or false)
    @Published var isAlertVisible: Bool = false
    
    private let signUpUseCase: SignUpUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(signUpUseCase: SignUpUseCase) {
        self.signUpUseCase = signUpUseCase
    }
}

extension SignUpViewModel: SignUpVM {
    //MARK: - register for Student
    func executeStudentRegister(id: String, pw: String, name: String, job: String, collage: String,
                                department: String, grade: String, dayOrNight: String, semester: String) {
        let data = [
            "signUpId": id, "signUpPassword": pw, "signUpName": name, "signUpJob": job, "signUpCollege": collage,
            "signUpDepartment": department, "signUpGrade": grade, "signUpDayOrNight": dayOrNight, "signUpSemester": semester
        ]
        
        signUpUseCase.execute(data)
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
                    self?.signUpResult = true
                } else {    //Sign up failed
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
        
        signUpUseCase.execute(data)
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
                    self?.signUpResult = true
                } else {    //Sign up Fail
                    self?.signUpResult = false
                }
            })
            .store(in: &cancellables)
    }
}
