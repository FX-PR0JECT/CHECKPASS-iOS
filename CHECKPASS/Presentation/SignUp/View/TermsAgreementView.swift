//
//  TermsAgreementView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/29/23.
//

import SwiftUI

struct TermsAgreementView<SVM: UserInfoInputVM>: View {
    @EnvironmentObject private var signUpViewModel: SVM
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Text("이용약관 동의").bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.userInfoInputGray)
                    .frame(height: UIScreen.main.bounds.width * 0.13)
                
                HStack {
                    AgreementButton(status: Binding(
                        get: {
                            self.signUpViewModel.defaultStates["agreement"] ?? .isInvalid
                        }, set: { newValue in
                            self.signUpViewModel.defaultStates["agreement"] = newValue
                        }))
                    
                    Text("개인정보 수집 및 이용에 동의합니다")
                    
                    Spacer()
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(signUpViewModel.defaultStates["agreement"] == .isValid || signUpViewModel.defaultStates["agreement"] == .isInitial ? .userInfoInputGray : .red, lineWidth: 1)
                        .frame(height: UIScreen.main.bounds.width * 0.13)
                }
            }
            
            if signUpViewModel.defaultStates["agreement"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("이용약관에 동의해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    TermsAgreementView<SignUpViewModel>()
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
