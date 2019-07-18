//
//  AchievementsViewController.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class AchievementsViewController: ViewController {

  weak var achivementsCollectionView: UICollectionView?

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.view.alpha = 0

    guard let viewModel = self.viewModel as? AchievementsViewModel else { return }

    self.achivementsCollectionView = viewModel.getCollectionView(withSuperView: self.view)
    self.achivementsCollectionView?.dataSource = self
    self.achivementsCollectionView?.delegate = self
    viewModel.registerCell(inCollectionView: achivementsCollectionView)
    viewModel.addCloseGesture(target: self, action: #selector(dismissView), toView: self.achivementsCollectionView)
  }

  @objc func dismissView() {
    self.dismiss(animated: true, completion: nil)
  }

}

//MARK: - Collection View Protocols
extension AchievementsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let viewModel = self.viewModel as? AchievementsViewModel else { return 0 }
    return viewModel.achievements.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let emptyCell = UICollectionViewCell()
    guard let viewModel = self.viewModel as? AchievementsViewModel else { return emptyCell }
    return viewModel.getCell(inCollectionView: collectionView, forIndexPath: indexPath) ?? emptyCell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: self.view.frame.width - 50, height: 150)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0	, left: 25, bottom: 0, right: 25)
  }
}

