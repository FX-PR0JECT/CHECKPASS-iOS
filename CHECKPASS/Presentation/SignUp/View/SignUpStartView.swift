//
//  JobPickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/4/24.
//

import SwiftUI

enum JobType: String {
    case student = "학생"
    case professor = "교수"
    case staff = "교직원"
    
    func getEnglishData() -> String {
        switch self {
        case .professor:
            return "PROFESSOR"
        case .staff:
            return "STAFF"
        case .student:
            return "STUDENTS"
        }
    }
}

struct SignUpStartView<SVM: SignUpVM>: View {
    @StateObject private var signUpViewModel: SVM
    @Environment(\.colorScheme) private var colorScheme
    @State private var selectedJob: JobType?
    @State private var showNextView: Bool = false
    @Binding private var showSignUpView: Bool
    
    init(viewModel: SVM, showSignUpView: Binding<Bool>) {
        _signUpViewModel = StateObject(wrappedValue: viewModel)
        _showSignUpView = showSignUpView
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("출석 체크를 간편하게!")
                .bold()
                .font(.title)
            
            Text("어디서든 쉽게 이용하세요")
                .bold()
                .font(.title2)
            
            if colorScheme == .light {
                Image("signUpImage_light")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("signUpImage_dark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            Spacer()
            
            Text("구분을 선택해 주세요")
                .bold()
                .font(.subheadline)
            
            //MARK: - Job Picker
            HStack(spacing: 10) {
                JobPicker(selectedJob: $selectedJob, type: .student)
                
                JobPicker(selectedJob: $selectedJob, type: .professor)
                
                JobPicker(selectedJob: $selectedJob, type: .staff)
            }
            .padding(.bottom)
            
            Button(action: {
                showNextView.toggle()
            }, label: {
                Text("다음")
                    .bold()
                    .padding(.all, 15)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(selectedJob == .none ? .gray : .blue)
                    .cornerRadius(30)
            })
            .disabled(selectedJob == .none)
        }
        .padding()
        .navigationTitle("시작하기")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $showNextView, destination: {
            SignUpView<SVM>(selectedJob: $selectedJob, showNextView: $showNextView, showSignUpView: $showSignUpView)
                .environmentObject(signUpViewModel)
        })
        .onChange(of: selectedJob) { newValue in
            signUpViewModel.defaultStates["job"] = .isValid
        }
    }
}

#Preview {
    SignUpStartView(viewModel: AppDI.shared().getSignUpViewModel(), showSignUpView: .constant(true))
}
