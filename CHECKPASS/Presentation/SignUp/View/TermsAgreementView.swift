//
//  TermsAgreementView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/29/23.
//

import SwiftUI

struct TermsAgreementView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            HStack {
                Text("이용약관 동의").bold().font(.subheadline).foregroundColor(colorScheme == .light ? .black : .white)
                
                Spacer()
            }
            .offset(x: 16)
            
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(CustomColor.getSignUpInputGray(colorScheme))
                    .frame(height: UIScreen.main.bounds.width * 0.13)
                
                HStack {
                    AgreementButton(status: Binding(
                        get: {
                            self.signUpViewModel.states["agreement"] ?? .isInvalid
                        }, set: { newValue in
                            self.signUpViewModel.states["agreement"] = newValue
                        }))
                    
                    Text("개인정보 수집 및 이용에 동의합니다")
                    
                    Spacer()
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(signUpViewModel.states["agreement"] == .isValid || signUpViewModel.states["agreement"] == .isInitial ? CustomColor.getSignUpInputGray(colorScheme) : .red, lineWidth: 1)
                        .frame(height: UIScreen.main.bounds.width * 0.13)
                }
            }
            
            if signUpViewModel.states["agreement"] == .isBlank {
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
    TermsAgreementView()
        .environmentObject(SignUpViewModel())
}
