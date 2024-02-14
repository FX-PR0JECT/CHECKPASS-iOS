//
//  AppDI.swift
//  CHECKPASS
//
//  Created by 이정훈 on 1/3/24.
//

class AppDI {
    private static let instance: AppDI = AppDI()    //singleton instance
    private let dataSource = DefaultDataSource()    //DataSource
    
    private init() {}
    
    static func shared() -> AppDI {
        return instance
    }
    
    func getEditUserInfoViewModel() -> EditUserInfoViewModel {
        let viewModel = EditUserInfoViewModel()
        
        return viewModel
    }
    
    //get UserInfo ViewModel
    func getUserInfoViewModel() -> UserInfoViewModel {
        let repository = DefaultUserRepository(dataSource: dataSource)
        let useCase = DefaultGetUserInfoUseCase(repository: repository)
        let viewModel = UserInfoViewModel(useCase: useCase)
        
        return viewModel
    }
    
    //get SignUp ViewModel
    func getSignUpViewModel() -> SignUpViewModel {
        //Repository
        let authRepository = DefaultAuthRepository(dataSource: dataSource),
            departmentsRepository = DefaultDepartmentsRepository(dataSource: dataSource),
            collegesRepository = DefaultCollegesRepository(dataSource: dataSource)
        //UseCase
        let signUpUseCase = DefaultSignUpUseCase(repository: authRepository),
            idDuplicationCheckUseCase = DefaultIdDuplicateCheckUseCase(repository: authRepository),
            getDepartmentsUseCase = DefaultGetDepartmentsUseCase(departmentsRepository: departmentsRepository, collegesRepository: collegesRepository)
        //ViewModel
        let viewModel = SignUpViewModel(signUpUseCase: signUpUseCase, idDuplicationCheckUseCase: idDuplicationCheckUseCase, getDepartmentsUseCase: getDepartmentsUseCase)
        
        return viewModel
    }
    
    //get SignIn ViewModel
    func getAuthViewModel() -> AuthViewModel {
        //Repository
        let repository = DefaultAuthRepository(dataSource: dataSource)
        //UseCase
        let signInUseCase = DefaultSignInUseCase(repository: repository)
        let logoutUseCase = DefaultLogoutUseCase(repository: repository)
        //ViewModel
        let viewModel = AuthViewModel(signInUseCase: signInUseCase, logoutUseCase: logoutUseCase)
        
        return viewModel
    }
}
