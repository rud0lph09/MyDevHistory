//
//  AchievementCell.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class AchievementCell: UICollectionViewCell, FillableCell {

  var viewModel: AchievemntCellViewModel?

  weak var achievementContainerView: UIView?
  weak var dateLabel: UILabel?
  weak var titleLabel: UILabel?
  weak var imageView: UIImageView?

  func fill(withViewModel viewModel: ViewModel?) {
    guard let achievementCellModel = viewModel as? AchievemntCellViewModel else { return }
    self.viewModel = achievementCellModel
    self.backgroundColor = UIColor.clear
    achievementContainerView = self.viewModel?.addAchievementBaseView(toSuperView: self)
    imageView = self.viewModel?.addAchivementImageView(toSuperView: achievementContainerView)
    self.viewModel?.getAchievementImage(forView: imageView)
    titleLabel = self.viewModel?.addAchievementLabel(toSuperView: achievementContainerView)
    dateLabel = self.viewModel?.addAchievementDateLabel(toSuperView: achievementContainerView)
  }
}
