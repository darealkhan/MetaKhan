//
//  HomeViewController.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 21.06.23.
//

import Foundation
import UIKit
import SnapKit
import SkeletonView

final class HomeViewController: BaseViewController {
  
  override var navigationBarTitle: String { return "Home" }
  override var isTabBarAvailable: Bool { return true }
  
  private var collectionViewManager = HomeCollectionViewManager()
  private var collectionView: UICollectionView!
  
  private var viewModel = HomeViewModel()
  
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
    viewModel.startLoadingSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.startLoading()
      }.store(in: &cancellables)
    
    viewModel.stopLoadingSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.stopLoading()
      }.store(in: &cancellables)
    
    viewModel.setAllPostsSubject
      .sink { [weak self] posts in
        guard let self = self else { return }
        self.collectionViewManager.setPosts(with: self.collectionView, posts: posts)
      }.store(in: &cancellables)
    
    viewModel.getAllPostsSubject.send(())
  }
  
  override func startLoading() {
    startSkeletoning([
      collectionView
    ])
  }
  
  override func stopLoading() {
    stopSkeletoning([
      collectionView
    ])
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
    collectionViewManager.collectionViewItemCount(with: collectionView, section: section)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    collectionViewManager.collectionViewCell(with: collectionView, indexPath: indexPath)
  }
}

extension HomeViewController: SkeletonCollectionViewDataSource {
  func numSections(in collectionSkeletonView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
    return HomePostCell.reuseIdentifier
  }
  
  func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
    let cell = skeletonView.reusable(HomePostCell.self, for: indexPath)
    return cell
  }
}
