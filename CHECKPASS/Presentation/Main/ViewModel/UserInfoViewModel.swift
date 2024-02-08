//
//  UserInfoViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine

final class UserInfoViewModel {
    @Published var simpleUserInfo: SimpleUserInfo?
    @Published var detailedUserInfo: User?
    @Published var showFailAlert: Bool = false
    
    private let useCase: GetUserInfoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: GetUserInfoUseCase) {
        self.useCase = useCase
    }
}

extension UserInfoViewModel: UserInfoVM {
    //MARK: - Fetch simple user info
    func getSimpleUserInfo() {
        useCase.executeForSimpleUserInfo()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("successfully fetched simple user info")
                case .failure(let error):
                    self?.showFailAlert.toggle()
                    print("UserInfoViewModel.getSimpleUserInfo() Error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.simpleUserInfo = $0
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Fetch detail user info
    func getDetailedUserInfo() {
        useCase.executeForDetailedUserInfo()
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("successfully fetched detailed user info")
                case .failure(let error):
                    self?.showFailAlert.toggle()
                    print("UserInfoViewModel.getDetailedUserInfo() Error: ", error)
                }
            }, receiveValue: { [weak self] in
                self?.detailedUserInfo = $0
            })
            .store(in: &cancellables)
    }
}
