//
//  SearchResultViewController.swift
//  itunes-vipTests
//
//  Created by Utsav Patel on 18/10/21.
//

import XCTest

@testable import itunes_vip
import XCTest

class MovieDetailViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: SearchResultViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupMovieDetailViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupMovieDetailViewController()
  {
    sut = SearchResultViewController()
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class MovieDetailBusinessLogicSpy: SearchResultBusinessLogic
    {
      
    var movieDetailCalled = false

    func updateMusic() {
        movieDetailCalled = true
    }
 
  }
  
  // MARK: Tests
  
  func testShouldFetchMovieDetailsWhenLoaded()
  {
    // Given
    let spy = MovieDetailBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.movieDetailCalled, "viewDidLoad() should ask the interactor to show result")
  }
}
