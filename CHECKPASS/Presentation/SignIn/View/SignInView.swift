//
//  SignInView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/22/23.
//

import SwiftUI

struct SignInView<KVM: KeyboardVM, SVM: AuthVM>: View {
    @EnvironmentObject private var keyboardViewModel: KVM
    @EnvironmentObject private var signInViewModel: SVM
    @State private var id: String = ""
    @State private var pw: String = ""
    @State private var showSignUpView: Bool = false
    @State private var showFindPwView: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                //MARK: - Background Image
                Image("SignIn_Background")
                    .resizable()
                    .ignoresSafeArea()
                
                //MARK: - Logo Image
                Image("CheckPass_Text")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width * 0.56)
                    .offset(y: keyboardViewModel.isKeyboardVisible ? -UIScreen.main.bounds.width * 0.3 : -UIScreen.main.bounds.width * 0.5)
                
                VStack(spacing: 15) {
                    //MARK: - Id input TextField
                    IdTextFieldView(id: $id)
                    
                    //MARK: - Password input TextField
                    PasswordTextFieldView(pw: $pw)
                    
                    //MARK: - Sign In Button
                    Button(action: {
                        dismissKeyboard()
                        signInViewModel.executeSignIn(id: id, password: pw)
                    }, label: {
                        if signInViewModel.isSignInProgress {
                            ProgressView()
                                .padding(.all, 15)
                                .frame(maxWidth: .infinity)
                                .tint(.white)
                                .background(.black)
                                .cornerRadius(30)
                        } else {
                            Text("로그인")
                                .bold()
                                .padding(.all, 15)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(30)
                        }
                    })
                    
                    HStack(spacing: 15) {
                        //MARK: - Create new account Button
                        Button(action: {
                            showSignUpView.toggle()
                        }, label: {
                            Text("새 계정 만들기")
                                .foregroundColor(CustomColor.SignInGray)
                        })
                        
                        //MARK: - Contour
                        Rectangle()
                            .foregroundColor(CustomColor.SignInGray)
                            .frame(width: 2, height: 20)
                        
                        //MARK: - Find Password Button
                        Button(action: {
                            showFindPwView.toggle()
                        }, label: {
                            Text("비밀번호 찾기")
                                .foregroundColor(CustomColor.SignInGray)
                        })
                    }
                    .padding(.top, 20)
                }
                .padding()
                .offset(y: keyboardViewModel.isKeyboardVisible ? UIScreen.main.bounds.width * 0.2 : 0)
            }
            .navigationDestination(isPresented: $showSignUpView, destination: {
                SignUpStartView(viewModel: AppDI.shared().getSignUpViewModel(), showSignUpView: $showSignUpView)
            })
            .navigationDestination(isPresented: $showFindPwView, destination: {
                FindPwView()
            })
            .alert(isPresented: $signInViewModel.showSignInAlert) {
                switch signInViewModel.alertType {
                case .isFailed:
                    Alert(title: Text("알림"),
                          message: Text("아이디 또는 비밀번호가 올바르지 않아요"),
                          dismissButton: .default(Text("확인")))
                case .isEmpty:
                    Alert(title: Text("알림"),
                          message: Text("아이디와 비밀번호를 입력해 주세요"),
                          dismissButton: .default(Text("확인")))
                case .none:
                    fatalError()
                }
            }
        }
    }
}

#Preview {
    SignInView<KeyboardViewModel, AuthViewModel>()
        .environmentObject(KeyboardViewModel())
        .environmentObject(AppDI.shared().getAuthViewModel())
}
