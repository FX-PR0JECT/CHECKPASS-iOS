//
//  AttendanceViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/21/24.
//

import Foundation

protocol AttendanceViewModel: ObservableObject {
    var result: Bool? { get set }
    var resultSet: String { get set }
    var isProgress: Bool { get set }
}
