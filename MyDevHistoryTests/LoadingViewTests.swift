//
//  LoadingViewTests.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/29/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit
import XCTest
@testable import MyDevHistory

class LoadingViewTests: XCTestCase {
  var loadingView: LoadingView?

  override func setUp() {
    let testView = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
    let loadingViewModel = LoadingViewModel(withLoadingMessage: "TestMessage")
    loadingView = LoadingView(withViewModel: loadingViewModel, inSuperView: testView)
  }

  func testActivityViewIsAnimated() {
    loadingView?.show()
    let activityViewIsAnimated = loadingView?.activityView?.isAnimating
    XCTAssert(activityViewIsAnimated ?? false, "ActivityView is not animated")
  }

  func testActivityViewShouldNotBeAnimated() {
    loadingView?.hide()
    let activityViewIsNotAnimated = !(loadingView?.activityView?.isAnimating ?? true)
    XCTAssert(activityViewIsNotAnimated, "ActivityView is animated")
  }
}
