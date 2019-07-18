//
//  CellAnimator.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/25/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

final class CellAnimator {

  var delay: Double = 0
  var timer: Timer?



  /// This method animates a UITableViewCell for easy and cool transition
  ///
  /// - Parameters:
  ///   - cell: The cell to animate
  ///   - addingUpDelay: Defaults to false. Set to true ONLY if you want to animate varius cells at once. this will give the effect of them appearing one by one.
  func animateAppearingCell(_ cell: UITableViewCell?, addingUpDelay: Bool = false) {
    if addingUpDelay && timer == nil {
      self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (timer) in
        self.delayTimerHandler()
      })
    }
    guard let targetCell = cell else { return }
    DispatchQueue.main.async {
      self.delay += addingUpDelay ? 0.025 : 0
      targetCell.alpha = 0
      targetCell.contentView.transform = CGAffineTransform.init(scaleX: 0.2, y: 0.2)
      UIView.animate(withDuration: 0.15, delay: self.delay, options: .curveEaseOut, animations: {
        targetCell.alpha = 1
        targetCell.contentView.transform = CGAffineTransform.identity
      }, completion: nil)
    }
  }


  /// Handler for the delay Timer
  private func delayTimerHandler() {
    delay = 0
    timer = nil
  }

}
