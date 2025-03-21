//
//  UnitTestingUserDetailVM_Tests.swift
//  SevenAppsCaseTests
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import XCTest
@testable import SevenAppsCase

final class UnitTestingUserDetailVM_Tests: XCTestCase {
    // MARK: - Properties
    
    private var sut: UserDetailVM!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_UserDetailVM_WhenInitializedWithUser_StoresUserCorrectly() {
        // Given
        let user = createUser(id: 123)
        
        // When
        sut = UserDetailVM(user: user)
        
        // Then
        XCTAssertNotNil(sut.user, "User should not be nil")
        XCTAssertEqual(sut.user?.id, 123, "User ID should match the provided user")
    }
    
    func test_UserDetailVM_WhenInitializedWithNil_HasNilUser() {
        // Given
        let user: User? = nil
        
        // When
        sut = UserDetailVM(user: user)
        
        // Then
        XCTAssertNil(sut.user, "User should be nil")
    }
    
    func test_ViewDidLoad_WhenCalled_DoesNotChangeState() {
        // Given
        let user = createUser(id: 456)
        sut = UserDetailVM(user: user)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(sut.user?.id, 456, "User should remain unchanged after viewDidLoad")
    }
    
    func test_UserDetailVM_WhenInitializedWithUserHavingAllProperties_MaintainsAllProperties() {
        // Given
        let user = createUser(
            id: 789,
            name: "Test User",
            username: "testuser",
            email: "test@example.com",
            city: "Test City"
        )
        
        // When
        sut = UserDetailVM(user: user)
        
        // Then
        XCTAssertEqual(sut.user?.id, 789, "User ID should match")
        XCTAssertEqual(sut.user?.name, "Test User", "User name should match")
        XCTAssertEqual(sut.user?.username, "testuser", "Username should match")
        XCTAssertEqual(sut.user?.email, "test@example.com", "Email should match")
        XCTAssertEqual(sut.user?.address?.city, "Test City", "City should match")
    }
    
    // MARK: - Helper Methods
    
    private func createUser(
        id: Int,
        name: String = "Default Name",
        username: String = "default_username",
        email: String = "default@example.com",
        city: String = "Default City"
    ) -> User {
        let geo = Geo(lat: "-100",
                      lng: "-100")
        
        let address = Address(street: "Test Street",
                              suite: "Suite 1",
                              city: city,
                              zipcode: "12345",
                              geo: geo)
        
        let company = Company(name: "7Apps",
                              catchPhrase: "Multi-layered client-server neural-net",
                              bs: "harness real-time e-markets")
        return User(id: id,
                    name: name,
                    username: username,
                    email: email,
                    address: address,
                    phone: "",
                    website: "google.com",
                    company: company)
    }
}
