//
//  IdDuplicationCheckUseCaseTest.swift
//  CHECKPASSTests
//
//  Created by 이정훈 on 1/9/24.
//

import XCTest
import Combine
@testable import CHECKPASS

final class IdDuplicateCheckUseCaseTest: XCTestCase {
    private var authRepository: AuthRepository!
    private var dataSource: DataSource!
    private var usecase: IdDuplicateCheckUseCase!
    private var cancellables = Set<AnyCancellable>()


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.dataSource = DefaultDataSource()
        self.authRepository = DefaultAuthRepository(dataSource: dataSource)
        self.usecase = DefaultIdDuplicateCheckUseCase(repository: authRepository)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        test_signUpTextField_inputId_showIdDuplicationCheck()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            test_signUpTextField_inputId_showIdDuplicationCheck()
        }
    }
    
    func test_signUpTextField_inputId_showIdDuplicationCheck() {
        let result: AuthResult = AuthResult(
            result: true,
            resultSet: "사용 가능한 아이디입니다."
        )
        
        print("start test")
        usecase.execute("1234567")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successuflly checked id duplication")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: {
                XCTAssertEqual(result, $0, "unexpected result")
            })
            .store(in: &cancellables)
    }

}

extension AuthResult: Equatable {
    public static func == (lhs: AuthResult, rhs: AuthResult) -> Bool {
        if lhs.result == rhs.result && lhs.resultSet == rhs.resultSet {
            return true
        } else {
            return false
        }
    }
}
