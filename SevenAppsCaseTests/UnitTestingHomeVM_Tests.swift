//
//  UnitTestingHomeVM_Tests.swift
//  SevenAppsCaseTests
//
//  Created by Oguz Yildirim on 21.03.2025.
//

import XCTest
import Combine
@testable import SevenAppsCase

final class UnitTestingHomeVM_Tests: XCTestCase {
    // MARK: - Properties
    
    private var sut: HomeVM!
    private var mockRepository: MockHomeRepository!
    private var cancellables: Set<AnyCancellable>!
    
    // MARK: - Setup & Teardown
    
    override func setUp() {
        super.setUp()
        mockRepository = MockHomeRepository()
        sut = HomeVM(repo: mockRepository)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        cancellables = nil
        super.tearDown()
    }
    
    // MARK: - Test Cases
    
    func test_HomeVM_WhenInitialized_HasEmptyUserLists() {
        // Given
        // SUT initialized in setUp
        
        // Then
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertTrue(sut.filteredUsers.isEmpty)
    }
    
    func test_GetUsers_WhenRepositoryReturnsUsers_PopulatesUserLists() {
        // Given
        let mockUsers = createMockUsers(count: 3)
        mockRepository.usersToReturn = mockUsers
        
        // When
        let expectation = XCTestExpectation(description: "Get users completed")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.users.count, 3)
            XCTAssertEqual(self.sut.filteredUsers.count, 3)
            XCTAssertEqual(self.sut.users[0].id, mockUsers[0].id)
            XCTAssertEqual(self.sut.users[1].id, mockUsers[1].id)
            XCTAssertEqual(self.sut.users[2].id, mockUsers[2].id)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_GetUsers_WhenRepositoryReturnsError_UserListsRemainEmpty() {
        // Given
        let expectedError = NSError(domain: "TestError", code: 500, userInfo: nil)
        mockRepository.errorToReturn = expectedError
        
        // When
        let expectation = XCTestExpectation(description: "Get users completed with error")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertTrue(self.sut.users.isEmpty)
            XCTAssertTrue(self.sut.filteredUsers.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenQueryIsEmpty_ShowsAllUsers() {
        // Given
        let mockUsers = createMockUsers(count: 3)
        mockRepository.usersToReturn = mockUsers
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sut.filterUsers(with: "")
            XCTAssertEqual(self.sut.filteredUsers.count, 3)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenNameMatches_FiltersUsersByName() {
        // Given
        let user1 = createUser(
            id: 1,
            name: "John Smith",
            username: "user1_unique",
            email: "email1_unique@example.com",
            city: "City1_unique"
        )
        
        let user2 = createUser(
            id: 2,
            name: "David Jones",
            username: "user2_unique",
            email: "email2_unique@example.com",
            city: "City2_unique"
        )
        
        let user3 = createUser(
            id: 3,
            name: "Robert Brown",
            username: "user3_unique",
            email: "email3_unique@example.com",
            city: "City3_unique"
        )
        
        mockRepository.usersToReturn = [user1, user2, user3]
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users by name")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            XCTAssertEqual(self.sut.users.count, 3, "Should have loaded 3 users")
        
            self.sut.filterUsers(with: "John")
            
            XCTAssertEqual(self.sut.filteredUsers.count, 1, "Should find exactly 1 user with 'John'")
            
            if !self.sut.filteredUsers.isEmpty {
                XCTAssertEqual(self.sut.filteredUsers[0].id, 1, "Filtered user should have ID 1")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenUsernameMatches_FiltersUsersByUsername() {
        // Given
        let user1 = createUser(id: 1, username: "johndoe")
        let user2 = createUser(id: 2, username: "janesmith")
        mockRepository.usersToReturn = [user1, user2]
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users by username")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sut.filterUsers(with: "jane")
            XCTAssertEqual(self.sut.filteredUsers.count, 1)
            XCTAssertEqual(self.sut.filteredUsers[0].id, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenEmailMatches_FiltersUsersByEmail() {
        // Given
        let user1 = createUser(id: 1, email: "john@example.com")
        let user2 = createUser(id: 2, email: "jane@example.com")
        mockRepository.usersToReturn = [user1, user2]
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users by email")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sut.filterUsers(with: "jane@")
            XCTAssertEqual(self.sut.filteredUsers.count, 1)
            XCTAssertEqual(self.sut.filteredUsers[0].id, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenCityMatches_FiltersUsersByCity() {
        // Given
        let user1 = createUser(id: 1, city: "New York")
        let user2 = createUser(id: 2, city: "Los Angeles")
        mockRepository.usersToReturn = [user1, user2]
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users by city")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sut.filterUsers(with: "Los")
            XCTAssertEqual(self.sut.filteredUsers.count, 1)
            XCTAssertEqual(self.sut.filteredUsers[0].id, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_FilterUsers_WhenMultipleMatch_FilterShowsAllMatches() {
        // Given
        let user1 = createUser(id: 1, name: "John Smith")
        let user2 = createUser(id: 2, name: "Jane Smith")
        let user3 = createUser(id: 3, name: "Bob Johnson")
        mockRepository.usersToReturn = [user1, user2, user3]
        
        // When
        let expectation = XCTestExpectation(description: "Get and filter users with multiple matches")
        sut.getUsers()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.sut.filterUsers(with: "Smith")
            XCTAssertEqual(self.sut.filteredUsers.count, 2)
            
            let filteredIds = Set(self.sut.filteredUsers.map { $0.id })
            XCTAssertTrue(filteredIds.contains(1))
            XCTAssertTrue(filteredIds.contains(2))
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_ViewDidAppear_WhenCalled_CallsGetUsers() {
        // Given
        let mockUsers = createMockUsers(count: 2)
        mockRepository.usersToReturn = mockUsers
        
        // When
        sut.viewDidAppear()
        
        // Then
        let expectation = XCTestExpectation(description: "viewDidAppear calls getUsers")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.users.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    // MARK: - Helper Methods
    
    private func createMockUsers(count: Int) -> [User] {
        return (1...count).map { id in
            createUser(id: id)
        }
    }
    
    private func createUser(
        id: Int,
        name: String? = "User \(UUID().uuidString.prefix(8))",
        username: String? = "username\(UUID().uuidString.prefix(8))",
        email: String? = "user\(UUID().uuidString.prefix(8))@example.com",
        city: String? = "City \(UUID().uuidString.prefix(8))"
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

// MARK: - Mock Repository

private class MockHomeRepository: HomeRepositoryProtocol {
    var usersToReturn: [User]?
    var errorToReturn: Error?
    
    func getUsers() -> AnyPublisher<[User]?, Error> {
        if let error = errorToReturn {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return Just(usersToReturn)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
