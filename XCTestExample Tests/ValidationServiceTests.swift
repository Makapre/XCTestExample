//
//  ValidationServiceTest.swift
//  XCTestExample Tests
//
//  Created by Marius Preikschat on 17.06.21.
//

@testable import XCTestExample
import XCTest

class ValidationServiceTests: XCTestCase {
    var validationService: ValidationService!
    
    override func setUp() {
        super.setUp()
        validationService = ValidationService()
    }
    
    override func tearDown() {
        super.tearDown()
//        ValidationService = nil
    }
    
    func test_is_valid_username() {
        XCTAssertTrue(try validationService.isUsernameValid("abdc"))
        XCTAssertNoThrow(try validationService.isUsernameValid("abdc"))
    }
    
    func test_is_NOT_valid_username() {
        // too short
        XCTAssertFalse(try validationService.isUsernameValid("abc"))
        // too long
        XCTAssertFalse(try validationService.isUsernameValid("abcdefghijklmnopqrst"))
        // empty
        XCTAssertFalse(try validationService.isUsernameValid(""))
    }
    
    func test_is_nil_username() throws {
        let expectedError = ValidationError.isNil
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.isUsernameValid(nil)) {
            thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
    }
    
    func test_is_nil_password() throws {
        let expectedError = ValidationError.isNil
        var error: ValidationError?
        
        XCTAssertThrowsError(try validationService.isPasswordValid(nil)) {
            thrownError in
            error = thrownError as? ValidationError
        }
        
        XCTAssertEqual(expectedError, error)
        XCTAssertEqual(error?.errorDescription, "Is nil")
    }
    
    func test_is_valid_password() {
        XCTAssertTrue(try validationService.isPasswordValid("abdc"))
    }
    
    func test_is_NOT_valid_password() {
        let password: String = "abcdefghijklmnopqrst"
        
        XCTAssertTrue(password.count == 20)
        
        // too short
        XCTAssertFalse(try validationService.isPasswordValid("abc"))
        // too long
        XCTAssertFalse(try validationService.isPasswordValid(password))
        // empty
        XCTAssertFalse(try validationService.isPasswordValid(""))
    }
}
