//
//  AppDI.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

class AppDI {
    //singleton instance
    private static let instance: AppDI = AppDI()
    
    private init() {}
    
    static func shared() -> AppDI {
        return instance
    }
    
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
