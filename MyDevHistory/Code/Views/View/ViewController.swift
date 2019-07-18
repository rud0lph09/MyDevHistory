//
//  ViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/29/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  var viewModel: ViewModel?


  /// This method retruns a ViewController, when desired ViewController is in a UIStoryboard
  ///
  /// - Parameters:
  ///   - viewModel: the viewModel of the desired ViewController
  ///   - viewControllerID: the ID of the desired ViewController, this ID should be also defined on the Main storyboard
  /// - Returns: Desired ViewController as ViewController
  static func getController(withViewModel viewModel: ViewModel, andStoryboardViewControllerID viewControllerID: String) -> ViewController? {
    let storyBoard = UIStoryboard(name: StoryboardNames.main, bundle: nil)
    let controller = storyBoard.instantiateViewController(withIdentifier: viewControllerID) as? ViewController
    controller?.viewModel = viewModel
    return controller
  }


  /// This method returns a ViewController, when the desired ViewController is NOT on a UIStoryboard
  ///
  /// - Parameters:
  ///   - viewModel: the viewModel of the desired ViewController
  ///   - viewControllerID: the ID of the desired ViewController, this ID in this case doesnt matter if its defined on a storyboard. No storyboard based definition of a ViewController will be instantiated in this method.

  /// - Returns: Desired ViewController as ViewController
  static func getController(withViewModel viewModel: ViewModel, viewControllerID: String) -> ViewController? {
    switch viewControllerID {
    case ViewControllerStoryboardsID.achievementsView:
      let controller = AchievementsViewController()
      controller.viewModel = viewModel
      return controller
    default:
      return nil
    }
  }
}
