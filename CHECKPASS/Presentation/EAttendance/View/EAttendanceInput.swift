//
//  EAttendanceInput.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/18/24.
//

import SwiftUI

struct EAttendanceInput<T: AttendanceViewModel>: View {
    @EnvironmentObject private var viewModel: T
    @FocusState private var focusedField: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.white)
            .frame(height: UIScreen.main.bounds.height * 0.25)
            .shadow(color: Color(red: 213 / 255, green: 213 / 255, blue: 213 / 255), radius: 5, y: 3)
            .overlay {
                VStack {
                    VStack(alignment: .leading) {
                        Text("출석 코드")
                            .font(.title3)
                            .bold()
                        
                        if var viewModel = viewModel as? EAttendanceViewModel {
                            HStack(spacing: 25) {
                                CodeInput(input: Binding(get: {
                                    viewModel.input
                                }, set: { newValue in
                                    viewModel.input = newValue
                                }), index: 0)
                                
                                CodeInput(input: Binding(get: {
                                    viewModel.input
                                }, set: { newValue in
                                    viewModel.input = newValue
                                }), index: 1)
                                
                                CodeInput(input: Binding(get: {
                                    viewModel.input
                                }, set: { newValue in
                                    viewModel.input = newValue
                                }), index: 2)
                                
                                CodeInput(input: Binding(get: {
                                    viewModel.input
                                }, set: { newValue in
                                    viewModel.input = newValue
                                }), index: 3)
                            }
                            .onTapGesture {
                                focusedField = true
                            }
                        }
                    }
                    
                    CurrentTimeView()
                        .padding([.top, .bottom])
                }
            }
            .onAppear {
                focusedField = true
            }
    }
}

#Preview {
    EAttendanceInput<DefaultEAttendanceViewModel>()
        .environmentObject(AppDI.shared().getEAttendanceViewModel())
}
