//
//  UserJobPicker.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/4/24.
//

import SwiftUI

struct JobPicker: View {
    @Environment(\.colorScheme) private var colorScheme
    @Binding private var selectedJob: JobType?
    
    private var type: JobType
    
    init(selectedJob: Binding<JobType?>, type: JobType) {
        _selectedJob = selectedJob
        self.type = type
    }
    
    var body: some View {
        Button(action: {
            selectedJob = type
        }, label: {
            Text(type.rawValue)
                .padding()
                .foregroundColor(colorScheme == .light ? .black : .white)
                .frame(maxWidth: .infinity)
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(selectedJob == type ? .blue : Color(red: 182 / 255, green: 182 / 255, blue: 185 / 255), lineWidth: 2)
                }
        })
    }
}

#Preview {
    JobPicker(selectedJob: .constant(nil), type: .professor)
}
