//
//  LoadingViewMOdel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/24/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class LoadingViewModel: ViewModel {
  var loadingMessage: String?

  init(withLoadingMessage loadingMessage: String) {
    self.loadingMessage = loadingMessage
  }

  func activateContraintsFor(_ baseView: UIView){
    guard let superView = baseView.superview else { return }
    let containerGuide = superView.safeAreaLayoutGuide
    baseView.alpha = 0
    baseView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    baseView.translatesAutoresizingMaskIntoConstraints = false
    baseView.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
    baseView.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    baseView.leadingAnchor.constraint(equalTo: containerGuide.leadingAnchor).isActive = true
    baseView.trailingAnchor.constraint(equalTo: containerGuide.trailingAnchor).isActive = true
  }

  func getActivityContainerView(withinContainer containerView: UIView?) -> UIView? {
    guard let containerGuide = containerView?.safeAreaLayoutGuide else { return nil }
    let view = UIView(frame: .zero)
    view.backgroundColor = UIColor.white
    view.clipsToBounds = true
    view.layer.cornerRadius = 9
    containerView?.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: containerGuide.topAnchor, constant: 280).isActive = true
    view.leadingAnchor.constraint(equalTo: containerGuide.leadingAnchor, constant: 50).isActive = true
    view.trailingAnchor.constraint(equalTo: containerGuide.trailingAnchor, constant: -50).isActive = true
    view.heightAnchor.constraint(equalToConstant: 180).isActive = true
    return view
  }

  func getActivityIndicator(withinContainerView containerView: UIView?) -> UIActivityIndicatorView? {
    guard let containerGuide = containerView?.safeAreaLayoutGuide else { return nil }
    let view = UIActivityIndicatorView(frame: .zero)
    view.color = UIColor.black
    containerView?.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: containerGuide.topAnchor, constant: 10).isActive = true
    view.centerXAnchor.constraint(equalTo: containerGuide.centerXAnchor).isActive = true
    view.heightAnchor.constraint(equalToConstant: 60).isActive = true
    return view
  }

  func getActivityLabel(withinContainer container: UIView?, andMessage message: String?) -> UILabel? {
    guard let containerGuide = container?.safeAreaLayoutGuide else { return nil }
    let view = UILabel(frame: .zero)
    container?.addSubview(view)
    view.contentMode = .center
    view.translatesAutoresizingMaskIntoConstraints = false
    view.bottomAnchor.constraint(equalTo: containerGuide.bottomAnchor, constant: -20).isActive = true
    view.leftAnchor.constraint(equalTo: containerGuide.leftAnchor, constant: 20).isActive = true
    view.rightAnchor.constraint(equalTo: containerGuide.rightAnchor, constant: -20).isActive = true
    view.heightAnchor.constraint(equalToConstant: 80).isActive = true
    view.numberOfLines = 2
    view.text = message
    view.font = UIFont(name: "System", size: 15)
    view.textColor = UIColor.black.withAlphaComponent(0.6)
    return view
  }
}
