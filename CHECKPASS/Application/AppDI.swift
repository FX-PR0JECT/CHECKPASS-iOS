//
//  AppDI.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

class AppDI {
    private static let instance: AppDI = AppDI()    //singleton instance
    private let dataSource = DefaultDataSource()    //DataSource
    
    static func shared() -> AppDI {
        return instance
    }
    
    //get SignUp ViewModel
    func getSignUpViewModel() -> SignUpViewModel {
        //Repository
        let repository = DefaultAuthRepository(dataSource: dataSource)
        //UseCase
        let signUpUseCase = DefaultSignUpUseCase(repository: repository)
        let idDuplicationCheckUseCase = DefaultIdDuplicationCheckUseCase(repository: repository)
        //ViewModel
        let viewModel = SignUpViewModel(signUpUseCase: signUpUseCase, idDuplicationCheckUseCase: idDuplicationCheckUseCase)
        
        return viewModel
    }
    
    //get SignIn ViewModel
    func getSignInViewModel() -> DefaultSignInViewModel {
        //Repository
        let repository = DefaultAuthRepository(dataSource: dataSource)
        //UseCase
        let signInUseCase = DefaultSignInUseCase(repository: repository)
        //ViewModel
        let viewModel = DefaultSignInViewModel(usecase: signInUseCase)
        
        return viewModel
    }
}
