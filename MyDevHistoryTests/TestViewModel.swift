//
//  TestViewModel.swift
//  MyDevHistoryTests
//
//  Created by Rodolfo Castillo Vidrio on 7/29/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit
@testable import MyDevHistory

class TestViewModel: ViewModel {

  var supposedURLString = "https://cdn4.iconfinder.com/data/icons/ionicons/512/icon-help-128.png"
  var testSkill: SkillModel?

  override init() {
    super.init()
    testSkill = SkillModel(skillName: "RandomSkill", category: "randomCat", proficency: "randomProf", icon: supposedURLString)
  }

  func getSkillImage(completion: @escaping (UIImage?) -> ()) {
    self.getImage(fromURL: testSkill?.getIconURL(), completion: completion)
  }
}
