//
//  NameInputView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/28/23.
//

import SwiftUI

struct NameInputView<SVM: UserInfoInputVM>: View {
    @EnvironmentObject private var viewModel: SVM
    @Binding private var nameInput: String
    @Binding private var idInput: String
    
    init(nameInput: Binding<String>, idInput: Binding<String>? = nil) {
        _nameInput = nameInput
        _idInput = idInput ?? Binding.constant("")
    }
    
    var body: some View {
        VStack {
            UserInfoInputView(text: $nameInput,
                            inputState: Binding(
                            get: {
                                self.viewModel.defaultStates["name"] ?? .isInitial
                            }, set: { newValue in
                                self.viewModel.defaultStates["name"] = newValue
                            }),
                            header: "이름", placeholder: "이름을 입력해 주세요")
            
            //MARK: - Warning Message
            if viewModel.defaultStates["name"] == .isBlank {
                HStack(spacing: 5) {
                    Image(systemName: "info.circle")
                    
                    Text("이름을 입력해 주세요")
                    
                    Spacer()
                }
                .offset(x: 16)
                .font(.caption)
                .foregroundColor(.red)
            }
        }
        .onChange(of: nameInput) { newValue in
            withAnimation {
                if nameInput.isEmpty {
                    viewModel.defaultStates["name"] = .isBlank
                } else {
                    viewModel.defaultStates["name"] = .isValid
                }
            }
        }
        .onTapGesture {
            if let signUpViewModel = viewModel as? SignUpVM, !idInput.isEmpty {
                if viewModel.defaultStates["id"] == .isNotVerified {
                    signUpViewModel.executeIdDuplicateCheck(for: idInput)
                }
            }
        }
    }
}

#Preview {
    NameInputView<SignUpViewModel>(nameInput: .constant(""), idInput: .constant(""))
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
