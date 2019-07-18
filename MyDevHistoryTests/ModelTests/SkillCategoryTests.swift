//
//  MyDevHistoryTests.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
@testable import MyDevHistory

class SkillCategoryTest: XCTestCase {

  func testReturnsCorrectCategoryForSkill() {
    let expectedSkillCategory = SkillCategory.archPattern.rawValue
    let serviceReturnedSkillCategory = "arch"
    let skill = SkillModel(skillName: "RandomArch", category: serviceReturnedSkillCategory, proficency: "expert", icon: nil)
    let skillCategoryReturned = skill.getCategoryType()?.rawValue ?? ""
    XCTAssertEqual(expectedSkillCategory, skillCategoryReturned, "Category type not equal as expected")
  }

  func testCategoryForSkillIsInvalid() {
    let serviceReturnedSkillCategory = "frmwrk"
    let skill = SkillModel(skillName: "RnadomFramework", category: serviceReturnedSkillCategory, proficency: "expert", icon: nil)
    let skillCategoryReturned = skill.getCategoryType()
    XCTAssertNil(skillCategoryReturned, "Category Type Is Valid")
  }

  func testCategoryForSkillIsValid() {
    let serviceReturnedSkillCategory = "framework"
    let skill = SkillModel(skillName: "RnadomFramework", category: serviceReturnedSkillCategory, proficency: "expert", icon: nil)
    let skillCategoryReturned = skill.getCategoryType()
    XCTAssertNotNil(skillCategoryReturned, "Category Type Is Valid")
  }

  func testReturnsCorrectProficiencyForSkill() {
    let expectedSkillProficiency = Proficiency.expert.rawValue
    let serviceReturnedSkillProficiency = "expert"
    let skill = SkillModel(skillName: "RandomArch", category: "arch", proficency: serviceReturnedSkillProficiency, icon: nil)
    let skillProficiencyReturned = skill.getProficiency()?.rawValue ?? ""
    XCTAssertEqual(expectedSkillProficiency, skillProficiencyReturned, "Category Proficiency not equal as expected")
  }

  func testProficiencyForSkillIsInvalid() {
    let serviceReturnedSkillProficiency = "exprt"
    let skill = SkillModel(skillName: "RandomArch", category: "arch", proficency: serviceReturnedSkillProficiency, icon: nil)
    let skillProficiencyReturned = skill.getProficiency()
    XCTAssertNil(skillProficiencyReturned, "Category Proficiency Is Valid")
  }

  func testProficiencyForSkillIsValid() {
    let serviceReturnedSkillProficiency = "adept"
    let skill = SkillModel(skillName: "RandomArch", category: "arch", proficency: serviceReturnedSkillProficiency, icon: nil)
    let skillProficiencyReturned = skill.getProficiency()
    XCTAssertNotNil(skillProficiencyReturned, "Category Proficiency Is Valid")
  }

}
