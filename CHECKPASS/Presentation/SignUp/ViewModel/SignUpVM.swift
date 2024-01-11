//
//  SignUpVM.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Foundation
import Combine

protocol SignUpVM: ObservableObject {
    var defaultStates: Dictionary<String, InputState> { get set }
    var studentStates: Dictionary<String, InputState> { get set }
    var staffStates: Dictionary<String, InputState> { get set }
    var isAlertVisible: Bool { get set }
    var alertType: AlertType { get set }
    
    func executeStudentRegister(id: String, pw: String, name: String, job: String, collage: String,
                                department: String, grade: String, dayOrNight: String, semester: String)
    func executeStaffRegister(id: String, pw: String, name: String, job: String, collage: String, department: String, hireDate: String)
    func executeIdDuplicationCheck(for id: String)
}

//MARK: - Check Invalid InputStatus
extension SignUpVM {
    func verifyState(job: JobType) -> Bool {
        var result: Bool = true

        for key in defaultStates.keys {
            if defaultStates[key] == .isBlank || defaultStates[key] == .isInitial {
                defaultStates[key] = .isBlank
                result = false
            } else if defaultStates[key] == .isInvalid {
                result = false
            }
        }
        
        switch job {
        case .professor, .staff:
            for key in staffStates.keys {
                if staffStates[key] == .isBlank || staffStates[key] == .isInitial {
                    staffStates[key] = .isBlank
                    result = false
                } else if staffStates[key] == .isInvalid {
                    result = false
                }
            }
        case .student:
            for key in studentStates.keys {
                if studentStates[key] == .isBlank || studentStates[key] == .isInitial {
                    studentStates[key] = .isBlank
                    result = false
                } else if studentStates[key] == .isInvalid {
                    result = false
                }
            }
        }
        
        return result
    }
    
    func initializeStates() {
        //defaultStates initialize
        defaultStates.keys.forEach {
            defaultStates[$0] = .isInitial
        }
        
        //studentStates initiallize
        studentStates.keys.forEach {
            studentStates[$0] = .isInitial
        }
        
        //staffStates initiallize
        staffStates.keys.forEach {
            staffStates[$0] = .isInitial
        }
    }
}

//MARK: - Regular Expression
extension SignUpVM {
    //Password Validation Checking
    func checkPwValidation(_ pw: String) {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = passwordPredicate.evaluate(with: pw)
        
        if isValid {
            defaultStates["pw"] = .isValid
        } else {
            defaultStates["pw"] = .isInvalid
        }
    }
    
    //Email Validation Checking
    func checkEmailValidation(_ email: String) {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = emailPredicate.evaluate(with: email)
        
        if isValid {
            defaultStates["email"] = .isValid
        } else {
            defaultStates["email"] = .isInvalid
        }
    }
}
