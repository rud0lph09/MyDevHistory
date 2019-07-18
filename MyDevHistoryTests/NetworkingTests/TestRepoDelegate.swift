//
//  TestRepoDelegate.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import XCTest
import Foundation
@testable import MyDevHistory

class TestRepoDelegate: ResumeRepositoryDelegate {

  var repository: ResumeRepository?
  var profile: ProfileModel!
  var jobs: [JobModel] = []
  var skills: [SkillModel] = []
  var projects: [ProjectModel] = []
  var repoFinishedFetchingFromRemote: XCTestExpectation?
  var repoGotWrongData: XCTestExpectation?
  var data: Data?
  var serviceSessionMock = ServiceSessionMock()
  var lastErrorString: String?

  init() {
    self.loadJSON()
  }

  func callResumeService() {
    serviceSessionMock.data = data
    repository = ResumeRepository(withSession: serviceSessionMock)
    repository?.baseURL = TestService.baseURL
    repository?.endpoint = TestService.endpoint
    repository?.delegate = self
    repository?.getResume()
  }

  func loadWrongJSON() {
    let bundle = Bundle(for: DecodingTests.self)
    guard let path = bundle.path(forResource: "wrong", ofType: "json") else { return }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      self.data = data

    } catch {
      print("Could not parse JSON")
    }
  }

  func loadJSON() {
    let bundle = Bundle(for: DecodingTests.self)
    guard let path = bundle.path(forResource: "test", ofType: "json") else { return }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      self.data = data

    } catch {
      print("Could not parse JSON")
    }
  }

  func repository(_ repo: ResumeRepository, didFinishRequestWithErrorMessage error: String) {
    lastErrorString = error
    repoFinishedFetchingFromRemote?.fulfill()
  }

  func repository(_ repo: ResumeRepository, didFinishRequestWithResume resume: ResumeServiceResponseModel) {
    self.jobs = resume.jobs
    self.skills = resume.skills
    self.projects = resume.otherProjects
    self.profile = resume.profile
    repoFinishedFetchingFromRemote?.fulfill()
  }

  func repositoryWillStartRequest() {
    repoFinishedFetchingFromRemote = XCTestExpectation()
    repoGotWrongData = XCTestExpectation()
  }
}
