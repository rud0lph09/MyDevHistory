//
//  LoadingView.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/24/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class LoadingView: UIView {
  var viewModel: LoadingViewModel?

  weak var middleView: UIView?
  weak var activityView: UIActivityIndicatorView?
  weak var loadingLabel: UILabel?

  init(withViewModel viewModel: LoadingViewModel?, inSuperView superView: UIView?) {
    super.init(frame: .zero)
    self.viewModel = viewModel
    superView?.addSubview(self)
    viewModel?.activateContraintsFor(self)
    self.middleView = viewModel?.getActivityContainerView(withinContainer: self)
    self.activityView = viewModel?.getActivityIndicator(withinContainerView: middleView)
    self.loadingLabel = viewModel?.getActivityLabel(withinContainer: middleView, andMessage: viewModel?.loadingMessage)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  func loadData() {
    self.loadingLabel?.text = viewModel?.loadingMessage
  }

  func show() {
    activityView?.startAnimating()
    UIView.animate(withDuration: 0.3) {
      self.alpha = 1
    }
  }

  func hide() {
    activityView?.stopAnimating()
    UIView.animate(withDuration: 0.3) {
      self.alpha = 0
    }
  }
}
