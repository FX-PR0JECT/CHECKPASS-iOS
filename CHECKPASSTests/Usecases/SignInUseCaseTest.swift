//
//  SignInUseCaseTest.swift
//  CHECKPASSTests
//
//  Created by 이정훈 on 1/11/24.
//

import XCTest
import Combine
@testable import CHECKPASS

final class SignInUseCaseTest: XCTestCase {
    private var usecase: SignInUseCase!
    private var repository: AuthRepository!
    private var dataSource: DataSource!
    private var cancellables = Set<AnyCancellable>()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataSource = DefaultDataSource()
        repository = DefaultAuthRepository(dataSource: dataSource)
        usecase = DefaultSignInUseCase(repository: repository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        usecase = nil
        repository = nil
        dataSource = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        test_SignInView_tabSignInButton_returnSignInResult()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            test_SignInView_tabSignInButton_returnSignInResult()
        }
    }
    
    func test_SignInView_tabSignInButton_returnSignInResult() {
        let data = ["loginId": "123456789", "loginPassword": "123456a!"]
        
        usecase.executeForSignIn(data: data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully signed in")
                case .failure(let error):
                    print("DefaultSignInViewModel.executeSignIn(id:password:): ", error)
                }
            }, receiveValue: {
                XCTAssertTrue($0.result, "unexpected result")
            })
            .store(in: &cancellables)
    }
}
