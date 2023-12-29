//
//  SignUpVM.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import Foundation
import Combine

protocol SignUpVM: ObservableObject {
    var statuses: [InputStatus] { get set }
}

//MARK: - Check Invalid InputStatus
extension SignUpVM {
    func isvalidState() -> Bool {
        var result: Bool = true
        
        for i in 0..<statuses.count {
            if statuses[i] == .isBlank || statuses[i] == .isInitial {
                statuses[i] = .isBlank
                result = false
            } else if statuses[i] == .isInvalid {
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
            statuses[1] = .isValid
        } else {
            statuses[1] = .isInvalid
        }
    }
    
    //Email Validation Checking
    func checkEmailValidation(_ email: String) {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let isValid = emailPredicate.evaluate(with: email)
        
        if isValid {
            statuses[4] = .isValid
        } else {
            statuses[4] = .isInvalid
        }
    }
}
