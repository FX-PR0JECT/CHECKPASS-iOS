//
//  UserInfoViewModel.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/17/24.
//

import Combine

final class UserInfoViewModel {
    @Published var simpleUserInfo: SimpleUserInfo?
    
    private let useCase: GetUserInfoUseCase
    private var cancellables = Set<AnyCancellable>()
    
    init(useCase: GetUserInfoUseCase) {
        self.useCase = useCase
    }
}

extension UserInfoViewModel: UserInfoVM {
    //MARK: - Fetch simple user info
    func getSimpleUserInfo() {
        useCase.executeGetSimpleUserInfo()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully fetched user info")
                case .failure(let error):
                    print("UserInfoViewModel.getSimpleUserInfo(): ", error)
                }
            }, receiveValue: { [weak self] in
                self?.simpleUserInfo = $0
            })
            .store(in: &cancellables)
    }
}
