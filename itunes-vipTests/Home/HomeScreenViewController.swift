//
//  HomeScreenViewController.swift
//  itunes-vipTests
//
//  Created by Utsav Patel on 18/10/21.
//

import XCTest

@testable import itunes_vip
import XCTest

class HomeViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomeScreenViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupHomeViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomeViewController()
  {
    sut = HomeScreenViewController()
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class HomeBusinessLogicSpy: HomeScreenBusinessLogic
    {
      
    var fetchMoviesOnLoadCalled = false
    
      func fetchMusic(queryString: String?, entity: [String]) {
          fetchMoviesOnLoadCalled = true
      }
    
    
  }
  
  // MARK: Tests
  
  func testShouldFetchMoviesWhenIsLoaded()
  {
    // Given
    let spy = HomeBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.fetchMoviesOnLoadCalled, "viewDidLoad() should ask the interactor to fetch movies categories")
  }
}
