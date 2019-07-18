//
//  CommonTests.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
@testable import MyDevHistory

class CommonTests: XCTestCase {

  var testViewModel: TestViewModel?

  override func setUp() {
    testViewModel = TestViewModel()
  }

  func testURLIsValid() {
    let skill = testViewModel?.testSkill
    let skillIconURL = skill?.getIconURL()
    XCTAssertNotNil(skillIconURL,"\(testViewModel?.supposedURLString ?? "An empty URL") is not a valid URL" )
  }

  func testImageDownloadedCorrectly() {
    testViewModel?.getSkillImage { (skillImage) in
      XCTAssertNotNil(skillImage, "Image was nil")
    }
  }

  func testImageShouldNotExists() {
    testViewModel?.testSkill = SkillModel(skillName: "RandomSkill", category: "randomCat", proficency: "randomProf", icon: "supposedURLString")
    testViewModel?.getSkillImage { (skillImage) in
      XCTAssert(skillImage == Images.placeholder, "Image was not nil")
    }
  }

  func testLocalizable() {
    let expectedString = "Whoops!"
    let string = "error_title".localized
    XCTAssert(expectedString == string, "String was not localized")
  }

}
