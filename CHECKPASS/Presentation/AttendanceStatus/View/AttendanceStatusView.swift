//
//  AttendanceStatusView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import SwiftUI

struct AttendanceStatusView: View {
    private let lecture: Lecture
    
    init(lecture: Lecture) {
        self.lecture = lecture
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    AttendanceStatusView(lecture: Lecture.sampleData)
}
