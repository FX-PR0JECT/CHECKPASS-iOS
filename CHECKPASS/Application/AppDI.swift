//
//  AppDI.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

class AppDI {
    //singleton instance
    static let shared: AppDI = AppDI()
    
    private init() {}
    
    //get SignUpViewModel
    func getSignUpViewModel() -> SignUpViewModel {
        //DataSource
        let dataSource = DefaultSignUpDataSource()
        //Repository
        let repository = DefaultSignUpRepository(dataSource: dataSource)
        //UseCase
        let useCase = DefaultSignUpUseCase(repository: repository)
        //ViewModel
        let viewModel = SignUpViewModel(signUpUseCase: useCase)
        
        return viewModel
    }
}
