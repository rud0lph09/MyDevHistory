//
//  AchievmentsViewModel.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/22/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import UIKit

class AchievementsViewModel: ViewModel {

  var achievements: [AchievementsModel] = []

  init(withAchievements achievements: [AchievementsModel]) {
    self.achievements = achievements
  }

  func getCollectionView(withSuperView superView: UIView) -> UICollectionView {
    superView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: getFlowLayoutForCollectionView())
    superView.addSubview(collectionView)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor).isActive = true
    collectionView.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor).isActive = true
    collectionView.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalToConstant: superView.frame.height).isActive = true
    collectionView.backgroundColor = UIColor.clear
    return collectionView
  }

  func addCloseGesture(target: Any?, action: Selector?, toView view: UIView?) {
    let tapGesture = UITapGestureRecognizer(target: target, action: action)
    view?.addGestureRecognizer(tapGesture)
  }

  private func getFlowLayoutForCollectionView() -> UICollectionViewFlowLayout {
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    collectionViewFlowLayout.scrollDirection = .vertical
    return collectionViewFlowLayout
  }

  func registerCell(inCollectionView collectionView: UICollectionView?) {
    collectionView?.register(AchievementCell.self, forCellWithReuseIdentifier: CellReusableID.achievement)
  }

}

extension AchievementsViewModel: CollectionViewModelProtocol {
  func getCell(inCollectionView collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell? {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellReusableID.achievement, for: indexPath) as? AchievementCell
    let viewModel = AchievemntCellViewModel(withAchievement: achievements[indexPath.row])
    cell?.fill(withViewModel: viewModel)
    return cell
  }
  
}
