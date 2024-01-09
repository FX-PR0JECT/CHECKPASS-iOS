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
        let dataSource = DefaultDataSource()
        //Repository
        let repository = DefaultAuthRepository(dataSource: dataSource)
        //UseCase
        let signUpUseCase = DefaultSignUpUseCase(repository: repository)
        let idDuplicationCheckUseCase = DefaultIdDuplicationCheckUseCase(repository: repository)
        //ViewModel
        let viewModel = SignUpViewModel(signUpUseCase: signUpUseCase, idDuplicationCheckUseCase: idDuplicationCheckUseCase)
        
        return viewModel
    }
}
