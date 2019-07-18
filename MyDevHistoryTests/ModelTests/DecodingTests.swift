//
//  DecodingTests.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
@testable import MyDevHistory

class DecodingTests: XCTestCase {
  var serviceResponsMock: ResumeServiceResponseModel?

  override func setUp() {
    let bundle = Bundle(for: DecodingTests.self)
    guard let path = bundle.path(forResource: "test", ofType: "json") else { return }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      let decoder = JSONDecoder()
      let result = try decoder.decode(ResumeServiceResponseModel.self, from: data)
      self.serviceResponsMock = result
    } catch {
      print("Could not parse JSON")
    }
  }

  func testDecodingMockResponseDidGotExpectedProjects(){
    let expectedProjectsFromMock = 2
    let projects = serviceResponsMock?.otherProjects ?? []
    XCTAssertEqual(expectedProjectsFromMock, projects.count, "\(projects.count) projects were loaded, wich is not equal to expected projects: \(expectedProjectsFromMock)")
  }

  func testDecodingMockReponseDidGotExpectedJobs(){
    let expectedJobsFromMock = 4
    let jobs = serviceResponsMock?.jobs ?? []
    XCTAssertEqual(expectedJobsFromMock, jobs.count, "\(jobs.count) jobs were loaded, wich is not equal to expected number of jobs: \(expectedJobsFromMock)")
  }

  func testDecodingMockResponseDidGotExpectedSkills(){
    let expectedNumberOfSkills = 20
    let skills = serviceResponsMock?.skills ?? []
    XCTAssertEqual(expectedNumberOfSkills, skills.count, "\(skills.count) skills were loaded, wich is not equal to expected number of skills: \(expectedNumberOfSkills)")
  }

  func testDecodingSkillTypeFromMockResponse() {
    let skills = serviceResponsMock?.skills ?? []
    let randomIndex = Int.random(in: 0..<skills.count)
    let skill = skills[randomIndex]
    XCTAssertNotNil(skill.getCategoryType(), "Skill \(String(describing: skill.skillName)) whose category is \(String(describing: skill.category)) is not a valid category")
  }
}
