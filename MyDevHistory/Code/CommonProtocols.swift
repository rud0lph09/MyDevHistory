//
//  ImagePathProtocol.swift
//  MyDevHistory
//
//  Created by Rodolfo Castillo Vidrio on 7/18/19.
//  Copyright © 2019 Rodolfo Castillo Vidrio. All rights reserved.
//

import Foundation
import UIKit


protocol PathToURLProtocol {

  /// This method transforms if possible a String to URL. Implement it if needed
  ///
  /// - Parameter path: A String describing the path to be transform into URL
  /// - Returns: return a URL item representing the path
  func getURL(fromPath path: String?) -> URL?
}

protocol FillableCell {

  /// This method should be implemented in order to fill all the objects inside a cell using the viewModel for said cell
  ///
  /// - Parameter viewModel: ViewModel for the cell
  func fill(withViewModel viewModel: ViewModel?)
}

@objc protocol TableViewViewModelProtocol {

  /// This method takes some parameters and then returns a cell. This should be implemented on ViewModels to givethem the responsability of deciding which and what type of cell is going to show next
  ///
  /// - Parameters:
  ///   - tableView: Table view in which the cell will be added
  ///   - indexPath: IndexPath of where in the Table view the cell will be added
  /// - Returns: Returns an optional representing the cell to be added as UITableViewCell
  func getCell(inTableView tableView: UITableView, forIndexPath indexPath: IndexPath) -> UITableViewCell?

}

protocol CollectionViewModelProtocol {

  /// This method takes some parameters and then returns a UICollectionViewCell This method should be implemented in viewModels that represent that of a CollectionView
  ///
  /// - Parameters:
  ///   - collectionView: Collection view where the cell will be added
  ///   - indexPath: Index Path of where the cell will be added
  /// - Returns: Returns an optional representing the cell tobe added as a UICollectionVIew
  func getCell(inCollectionView collectionView: UICollectionView, forIndexPath indexPath: IndexPath) -> UICollectionViewCell?
}

@objc protocol Navigatable {

  /// This variable represents the Navigation Controller that should do actions like pop view controllers
  var navigationController: UINavigationController? { get set }

  /// This method takes a controller to access its navigationItem and add custom buttons or which ever item you like.
  ///
  /// - Parameter controller: Current Top View Controller∫
  func getNavBarItems(controller: UIViewController)

  /// Pops current top view controller from navigation controller previusly setted
  @objc func popViewController()

}

protocol ServiceSessionTypable {

  /// This method should be implemented for GET Http Requests
  ///
  /// - Parameters:
  ///   - url: Url to make the request to
  ///   - completion: completion block to excecute after the request
  func getData(from url: URL,
                completion: @escaping (Data?, Error?) -> Void)
}
