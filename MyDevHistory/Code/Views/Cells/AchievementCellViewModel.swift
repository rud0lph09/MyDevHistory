//
//  AchievementCellViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class AchievemntCellViewModel: ViewModel {

  var achievement: AchievementsModel?

  init(withAchievement achievement: AchievementsModel?) {
    super.init()
    self.achievement = achievement
  }

  func getAchievementImage(forView view: UIImageView?) {
    getImage(fromURL: achievement?.getImageUrl()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  func addAchievementBaseView(toSuperView superView: UIView? ) -> UIView? {
    guard let targetSuperview = superView else { return nil }
    let view = UIView(frame: .zero)
    targetSuperview.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    view.leadingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.leadingAnchor).isActive = true
    view.trailingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.trailingAnchor).isActive = true
    view.heightAnchor.constraint(equalToConstant: 100).isActive = true
    view.layer.cornerRadius = 15
    view.clipsToBounds = true
    view.backgroundColor = UIColor.white
    return view
  }

  func addAchivementImageView(toSuperView superView: UIView?) -> UIImageView? {
    guard let targetSuperview = superView else { return nil }
    let view = UIImageView(frame: .zero)
    targetSuperview.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.topAnchor).isActive = true
    view.leadingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.leadingAnchor).isActive = true
    view.widthAnchor.constraint(equalToConstant: 100).isActive = true
    view.heightAnchor.constraint(equalToConstant: 100).isActive = true
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.backgroundColor = UIColor.lightGray
    return view
  }

  func addAchievementLabel(toSuperView superView: UIView?) -> UILabel? {
    guard let targetSuperview = superView else { return nil }
    let view = UILabel(frame: .zero)
    let font = UIFont(name: "System_Black", size: 20)
    targetSuperview.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
    view.leadingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.leadingAnchor, constant: 120).isActive = true
    view.trailingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.trailingAnchor, constant: 10)
    view.heightAnchor.constraint(equalToConstant: 50).isActive = true
    view.font = font
    view.text = achievement?.title
    view.contentMode = .left
    view.textColor = UIColor.darkGray
    return view
  }

  func addAchievementDateLabel(toSuperView superView: UIView?) -> UILabel? {
    guard let targetSuperview = superView else { return nil }
    let view = UILabel(frame: CGRect(x: 120, y: 50, width: targetSuperview.frame.width - 100, height: 30))
    let font = UIFont(name: "System_Black", size: 16)
    targetSuperview.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.topAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
    view.leadingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.leadingAnchor, constant: 120).isActive = true
    view.trailingAnchor.constraint(equalTo: targetSuperview.safeAreaLayoutGuide.trailingAnchor, constant: 10)
    view.heightAnchor.constraint(equalToConstant: 30).isActive = true
    view.font = font
    view.text = achievement?.date
    view.contentMode = .left
    view.textColor = UIColor.lightGray
    return view
  }

}
