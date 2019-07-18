//
//  MyDevHistoryUITests.swift
//  MyDevHistoryUITests
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest

class ResumeViewTests: XCTestCase {

  var app: XCUIApplication?

  override func setUp() {
    super.setUp()
    continueAfterFailure = false
    app = XCUIApplication()
    app?.launchArguments.append("--uitesting")
    app?.launch()
  }

  override func tearDown() {
  }

  func testOpenAchievementsView() {
    app?.buttons["My Achievements"].tap()
    XCTAssert(app?.collectionViews.firstMatch.exists ?? false, "There is no collection view on sight")
  }

  func testAchievementsViewFlow() {
    app?.buttons["My Achievements"].tap()
    app?.collectionViews.firstMatch.tap()
    XCTAssert(!(app?.collectionViews.firstMatch.exists ?? false), "There still is a collection view on sight")
  }

  func testOpenJobView() {
    let cell = app?.cells.containing(NSPredicate(format: "label CONTAINS %@", "Globant")).firstMatch
    cell?.tap()
    XCTAssert(app?.tables.firstMatch.exists ?? false, "There isnt a table view on sight")
  }

  func testOpenProjectViewFromJobView() {
    let cell = app?.cells.containing(NSPredicate(format: "label CONTAINS %@", "Globant")).firstMatch
    cell?.tap()
    app?.cells.firstMatch.tap()
    XCTAssert(app?.tables.firstMatch.exists ?? false, "There isnt a table view on sight")
  }

  func testOpenProjectView() {
    app?.swipeUp()
    app?.swipeUp()
    let cell = app?.cells.containing(NSPredicate(format: "label CONTAINS %@", "Scorp Viewer")).firstMatch
    cell?.tap()
    XCTAssert(app?.buttons["View more"].exists ?? false, "There isnt a table view on sight")
  }

  func testOpenSkillsView() {
    app?.swipeUp()
    app?.swipeUp()
    var cell = app?.cells.containing(NSPredicate(format: "label CONTAINS %@", "View More")).firstMatch
    cell?.tap()
    cell = app?.cells.containing(NSPredicate(format: "label CONTAINS %@", "Swift")).firstMatch
    XCTAssert(cell?.exists ?? false, "There isnt a cell with text swift on it")
  }

}
