//
//  SignUpVM.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Foundation
import Combine

protocol SignUpVM: ObservableObject {
    var states: Dictionary<String, InputState> { get set }
}

//MARK: - Check Invalid InputStatus
extension SignUpVM {
    func verifyState() -> Bool {
        var result: Bool = true

        for key in states.keys {
            if states[key] == .isBlank || states[key] == .isInitial {
                states[key] = .isBlank
                result = false
            } else if states[key] == .isInvalid {
                result = false
            }
        }
        
        return result
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
            states["pw"] = .isValid
        } else {
            states["pw"] = .isInvalid
        }
    }
    
    //Email Validation Checking
    func checkEmailValidation(_ email: String) {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = emailPredicate.evaluate(with: email)
        
        if isValid {
            states["email"] = .isValid
        } else {
            states["email"] = .isInvalid
        }
    }
}
