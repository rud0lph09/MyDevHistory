//
//  SkillCell.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell, FillableCell {

  var viewModel: SkillCellViewModel?
  @IBOutlet weak var iconView: UIImageView?
  @IBOutlet weak var skillLabel: UILabel?
  @IBOutlet weak var skillProficiencyLabel: UILabel?
  @IBOutlet weak var skillTypeLabel: UILabel?

  func fill(withViewModel viewModel: ViewModel?) {
    guard let cellViewModel = viewModel as? SkillCellViewModel else { return }
    self.viewModel = cellViewModel
    self.viewModel?.getSkillImage(forView: iconView)
    skillLabel?.text = self.viewModel?.skill?.skillName
    skillProficiencyLabel?.text = self.viewModel?.skill?.proficency
    skillTypeLabel?.text = self.viewModel?.skill?.category
  }

}
