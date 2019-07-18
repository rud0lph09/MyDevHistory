//
//  RepoTests.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
@testable import MyDevHistory

class RepoTests: XCTestCase {
  var repoDelegate: TestRepoDelegate!

  override func setUp() {
    repoDelegate = TestRepoDelegate()
    repoDelegate.callResumeService()
    guard let expectation = repoDelegate.repoFinishedFetchingFromRemote else { return }
    wait(for: [expectation], timeout: 3)
  }

  func testRepoResponseDidGotExpectedProjects(){
      let expectedProjectsFromMock = 2
      let projects = repoDelegate.projects
      XCTAssertEqual(expectedProjectsFromMock, projects.count, "\(projects.count) projects were loaded, wich is not equal to expected projects: \(expectedProjectsFromMock)")

  }

  func testDecodingMockReponseDidGotExpectedJobs(){
      let expectedJobsFromMock = 4
      let jobs = repoDelegate.jobs
      XCTAssertEqual(expectedJobsFromMock, jobs.count, "\(jobs.count) jobs were loaded, wich is not equal to expected number of jobs: \(expectedJobsFromMock)")


  }

  func testDecodingMockResponseDidGotExpectedSkills(){
      let expectedNumberOfSkills = 20
      let skills = repoDelegate.skills
      XCTAssertEqual(expectedNumberOfSkills, skills.count, "\(skills.count) skills were loaded, wich is not equal to expected number of skills: \(expectedNumberOfSkills)")

  }

  func testDecodingSkillTypeFromMockResponse() {
    let skills = repoDelegate.skills
    let randomIndex = skills.count > 0 ? Int.random(in: 0..<skills.count) : 0
    let skillCategoryType = skills.count > 0 ? skills[randomIndex].getCategoryType() : nil
    XCTAssertNotNil(skillCategoryType, "Skill category, not valid")

  }

  func testWrongResponse() {
	    repoDelegate.loadWrongJSON()
    repoDelegate.callResumeService()
    guard let expectation = repoDelegate.repoFinishedFetchingFromRemote else { return }
    wait(for: [expectation], timeout: 3)
    let errorMessage = repoDelegate.lastErrorString ?? ""
    let errorDidOccurredAndRepoResponseWasBad = errorMessage == ErrorMessages.parsingError
    XCTAssert(errorDidOccurredAndRepoResponseWasBad, "\(errorMessage), Error wasnt the expected one or didnt happened")
  }
}
