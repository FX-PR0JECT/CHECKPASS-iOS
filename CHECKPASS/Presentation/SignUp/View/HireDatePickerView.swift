//
//  HiredatePickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/4/24.
//

import SwiftUI

struct HireDatePickerView<SVM: SignUpVM>: View {
    @EnvironmentObject private var signUpViewModel: SVM
    @Binding private var selection: Date
    @Environment(\.colorScheme) private var colorScheme
    
    var header: String
    var title: String
    
    init(selection: Binding<Date>, header: String, title: String) {
        _selection = selection
        self.header = header
        self.title = title
    }
    
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
                
                DatePicker(selection: $selection, displayedComponents: .date) {
                    Text("입사 날짜를 선택해 주세요")
                }
                .padding([.trailing, .leading])
            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(signUpViewModel.staffStates["hireDate"] == .isValid || signUpViewModel.staffStates["hireDate"] == .isInitial ? CustomColor.getSignUpInputGray(colorScheme) : .red, lineWidth: 1)
                    .frame(height: UIScreen.main.bounds.width * 0.13)
            }
            
            if signUpViewModel.staffStates["hireDate"] == .isInvalid || signUpViewModel.staffStates["hireDate"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("입사일을 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: selection) { newValue in
            withAnimation {
                if newValue == Date(timeIntervalSince1970: 0) {
                    signUpViewModel.staffStates["hireDate"] = .isInvalid
                } else {
                    signUpViewModel.staffStates["hireDate"] = .isValid
                }
            }
        }
    }
}

#Preview {
    HireDatePickerView<SignUpViewModel>(selection: .constant(Date(timeIntervalSince1970: 0)), header: "입사일", title: "입사일을 선택해 주세요")
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
