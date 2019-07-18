//
//  SkillCellViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class SkillCellViewModel: ViewModel {
  var skill: SkillModel?
  init(withSkillModel skill: SkillModel?) {
    self.skill = skill
  }

  func getSkillImage(forView view: UIImageView?){
    getImage(fromURL: skill?.getIconURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }
}
