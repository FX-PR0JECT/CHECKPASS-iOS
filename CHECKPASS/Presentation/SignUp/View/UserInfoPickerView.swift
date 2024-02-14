//
//  UserPickerView.swift
//  CHECKPASS
//
//  Created by 이정훈 on 12/27/23.
//

import SwiftUI

struct UserInfoPickerView<SVM: UserInfoInputVM>: View {
    @EnvironmentObject private var viewModel: SVM
    @Binding private var selection: String
    @Binding private var idInput: String
    @Environment(\.colorScheme) private var colorScheme
    
    private var header: String
    private var title: String
    private var contents: [String]
    private var pos: String
    private var type: JobType?
    
    init(selection: Binding<String>, idInput: Binding<String>? = nil, header: String, title: String,
         contents: [String], pos: String, type: JobType? = nil) {
        _selection = selection
        _idInput = idInput ?? .constant("")
        self.header = header
        self.title = title
        self.contents = contents
        self.pos = pos
        self.type = type
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
                
                HStack {
                    Text(title)
                    
                    Spacer()
                    
                    Picker(title, selection: $selection) {
                        Text("선택").tag("선택")
                        
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
            
            if viewModel.defaultStates[pos] == .isBlank || viewModel.studentStates[pos] == .isBlank {
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
                        viewModel.studentStates[pos] = .isBlank
                    } else {
                        viewModel.studentStates[pos] = .isValid
                    }
                default:
                    if newValue == "선택" {
                        viewModel.defaultStates[pos] = .isBlank
                    } else {
                        viewModel.defaultStates[pos] = .isValid
                    }
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

extension UserInfoPickerView {
    private func getStrokeColor() -> Color {
        var state: InputState
        
        switch type {
        case .student:
            state = viewModel.studentStates[pos] ?? .isInvalid
        default:
            state = viewModel.defaultStates[pos] ?? .isInvalid
        }
        
        if state == .isBlank || state == .isInvalid {
            return .red
        } else {
            return CustomColor.getSignUpInputGray(colorScheme)
        }
    }
}

#Preview {
    UserInfoPickerView<SignUpViewModel>(selection: .constant(""), idInput: .constant(""), header: "header", title: "title", contents: ["선택", "학생", "교수", "교직원"], pos: "type")
        .environmentObject(AppDI.shared().getSignUpViewModel())
}
