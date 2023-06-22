//
//  MainTabBarView.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class MainTabBarView: UIView {
  
  let tabChangedSubject = PassthroughSubject<MainTabBarViewController.TabBarItem, Never>()
  let shareButtonTappedSubject = PassthroughSubject<Void, Never>()
  
  private var collectionView: UICollectionView!
  private var shareButton: UIButton!
  
  private var tabs = MainTabBarCell.UIModel.getCells(selectedCell: .home)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    backgroundColor = .systemBackground
    
    let divider = UIView.new {
      $0.backgroundColor = .secondarySystemBackground
    }
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.delegate = self
    collectionView.dataSource = self
    
    shareButton = UIButton(type: .system)
    shareButton.setImage(UIImage(named: "tabbar_share_ic"), for: .normal)
    shareButton.tintColor = AppColor.primaryColor
    shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    
    collectionView.register(MainTabBarCell.self)
    
    addSubViews([
      collectionView,
      shareButton,
      divider
    ])
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    shareButton.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.width.height.equalTo(30)
    }
    
    divider.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.width.equalToSuperview()
      make.height.equalTo(1)
    }
  }
  
  @objc private func shareButtonTapped() {
    shareButtonTappedSubject.send(())
  }
}

extension MainTabBarView: UICollectionViewDelegate, UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabs.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let model = tabs[indexPath.row]
    let cell = collectionView.reusable(MainTabBarCell.self, for: indexPath)
    cell.configureCell(with: model)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let selectedType = tabs[indexPath.row].type
    guard selectedType != .share else { return }
    tabs = MainTabBarCell.UIModel.getCells(selectedCell: selectedType)
    collectionView.reloadData()
    tabChangedSubject.send(selectedType)
  }
}

extension MainTabBarView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width / 5
    return CGSize(width: width, height: 60)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
