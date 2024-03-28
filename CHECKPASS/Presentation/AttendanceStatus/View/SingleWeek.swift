//
//  SingleWeek.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import SwiftUI

enum AttendanceStatus: String {
    case notEntered = "0"
    case attended = "1"
    case lateness = "2"
    case absence = "3"
    
    var color: Color {
        switch self {
        case .notEntered:
            return .gray
        case .attended:
            return .attended
        case .lateness:
            return .late
        case .absence:
            return .absence
        }
    }
}

struct SingleWeek: View {
    private let week: Int
    private let firstStatus: AttendanceStatus
    private let secondStatus: AttendanceStatus?
    
    init(week: Int, firstStatus: AttendanceStatus, secondStatus: AttendanceStatus? = nil) {
        self.week = week
        self.firstStatus = firstStatus
        self.secondStatus = secondStatus
    }
    
    var body: some View {
        if let secondStatus {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(stops: [Gradient.Stop(color: firstStatus.color, location: 0.5),
                                             Gradient.Stop(color: secondStatus.color, location: 0.5)],
                                     startPoint: .zero,
                                     endPoint: .bottomTrailing))
                .frame(width: UIScreen.main.bounds.width * 0.1,
                       height: UIScreen.main.bounds.width * 0.1)
                .overlay {
                    Text("\(week)")
                        .foregroundColor(.white)
                }
        } else {
            RoundedRectangle(cornerRadius: 10)
                .fill(firstStatus.color)
                .frame(width: UIScreen.main.bounds.width * 0.1,
                       height: UIScreen.main.bounds.width * 0.1)
                .overlay {
                    Text("\(week)")
                        .foregroundColor(.white)
                }
        }
    }
}

#Preview {
    SingleWeek(week: 1,
               firstStatus: .attended,
               secondStatus: .absence)
}
