//
//  HomeViewController.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 21.06.23.
//

import Foundation
import UIKit
import SnapKit

final class HomeViewController: BaseViewController {
  
  override var navigationBarTitle: String { return "Home" }
  override var isTabBarAvailable: Bool { return true }
  
  private var collectionViewManager = HomeCollectionViewManager()
  private var collectionView: UICollectionView!
  
  override func setupViews() {
    collectionView = collectionViewManager.collectionView()
    collectionView.delegate = self
    collectionView.dataSource = self
    
    view.addSubViews([
      collectionView
    ])
    
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
  }
  
  override func setupBinds() {
    
  }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 10
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    collectionViewManager.collectionViewCell(with: collectionView, indexPath: indexPath)
  }
}
