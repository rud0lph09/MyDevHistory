//
//  JobCellViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/19/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class JobCellViewModel: ViewModel {
  var job: JobModel?
  init(withJob job: JobModel?) {
    self.job = job
  }

  func getCompanyLogo(forView view: UIImageView?) {
    getImage(fromURL: job?.getCompanyLogoURL()) { (image) in
      DispatchQueue.main.async {
        view?.image = image
      }
    }
  }

  func getPeriodicity() -> String {
    guard let endDateString = job?.ended else {
      return job?.started ?? ""
    }
    return job?.started ?? "" + " - " + endDateString
  }
}
