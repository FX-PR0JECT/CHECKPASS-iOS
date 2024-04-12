//
//  SingleWeek.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/25/24.
//

import SwiftUI
import SkeletonUI

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
    private let firstStatus: AttendanceStatus?
    private let secondStatus: AttendanceStatus?
    
    init(week: Int, firstStatus: AttendanceStatus?, secondStatus: AttendanceStatus?) {
        self.week = week
        self.firstStatus = firstStatus
        self.secondStatus = secondStatus
    }
    
    var body: some View {
        if let firstStatus, let secondStatus {
            RoundedRectangle(cornerRadius: 10)
                .fill(LinearGradient(stops: [Gradient.Stop(color: firstStatus.color, location: 0.5),
                                             Gradient.Stop(color: secondStatus.color, location: 0.5)],
                                     startPoint: .zero,
                                     endPoint: .bottomTrailing))
//                .frame(width: UIScreen.main.bounds.width * 0.095,
//                       height: UIScreen.main.bounds.width * 0.095)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.095)
                .overlay {
                    Text("\(week)")
                        .foregroundColor(.white)
                }
        } else if let firstStatus {
            RoundedRectangle(cornerRadius: 10)
                .fill(firstStatus.color)
                .frame(width: UIScreen.main.bounds.width * 0.095,
                       height: UIScreen.main.bounds.width * 0.095)
                .overlay {
                    Text("\(week)")
                        .foregroundColor(.white)
                }
        } else {
            RoundedRectangle(cornerRadius: 10)
                .skeleton(with: true, shape: .rounded(.radius(10, style: .continuous)))
//                .frame(width: UIScreen.main.bounds.width * 0.095,
//                       height: UIScreen.main.bounds.width * 0.095)
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.width * 0.095)
        }
    }
}

#Preview {
    SingleWeek(week: 1,
               firstStatus: .attended,
               secondStatus: .absence)
}
