//
//  UserInfoVM.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Foundation

protocol UserInfoVM: ObservableObject {
    var simpleUserInfo: SimpleUserInfo? { get set }
}
