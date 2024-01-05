//
//  UserPickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct SignUpPickerView<SVM: SignUpVM>: View {
    @EnvironmentObject var signUpViewModel: SVM
    @Binding var selection: String
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var title: String
    var contents: [String]
    var pos: String
    var type: JobType = .none
    
    var body: some View {
        VStack {
            HStack {
                Text(header).bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(CustomColor.getSignUpInputGray(colorScheme))
                    .frame(height: UIScreen.main.bounds.width * 0.13)
                
                HStack {
                    Text(title)
                    
                    Spacer()
                    
                    Picker(title, selection: $selection) {
                        ForEach(contents, id: \.self) { content in
                            Text(content)
                        }
                    }
                }
                .padding([.trailing, .leading])
            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(getStrokeColor(), lineWidth: 1)
                    .frame(height: UIScreen.main.bounds.width * 0.13)
            }
            
            if signUpViewModel.defaultStates[pos] == .isBlank || signUpViewModel.studentStates[pos] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("\(header)를 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: selection) { newValue in
            withAnimation {
                switch type {
                case .student:
                    if newValue == "선택" {
                        signUpViewModel.studentStates[pos] = .isBlank
                    } else {
                        signUpViewModel.studentStates[pos] = .isValid
                    }
                default:
                    if newValue == "선택" {
                        signUpViewModel.defaultStates[pos] = .isBlank
                    } else {
                        signUpViewModel.defaultStates[pos] = .isValid
                    }
                }
            }
        }
    }
}

extension SignUpPickerView {
    private func getStrokeColor() -> Color {
        var state: InputState
        
        switch type {
        case .student:
            state = signUpViewModel.studentStates[pos] ?? .isInvalid
        default:
            state = signUpViewModel.defaultStates[pos] ?? .isInvalid
        }
        
        if state == .isBlank || state == .isInvalid {
            return .red
        } else {
            return CustomColor.getSignUpInputGray(colorScheme)
        }
    }
}

#Preview {
    SignUpPickerView<SignUpViewModel>(selection: .constant(""), header: "header", title: "title", contents: ["선택", "학생", "교수", "교직원"], pos: "type")
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
