//
//  EditUserInfoViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 2/13/24.
//

import Foundation

final class EditUserInfoViewModel: UserInfoInputVM {
    @Published var defaultStates: Dictionary<String, InputState> = ["name": .isInitial, "department": .isInitial]
    @Published var studentStates: Dictionary<String, InputState> = ["grade": .isInitial, "dayOrNight": .isInitial, "semesters": .isInitial]
    @Published var staffStates: Dictionary<String, InputState> = [:]
    @Published var isAlertVisible: Bool = false
    @Published var alertType: AlertType = .signUpSucceed
    @Published var departments: Departments?
    @Published var colleges: Colleges?
    
    func getDepartmentsData(of college: String) {
        //call function
    }
}
