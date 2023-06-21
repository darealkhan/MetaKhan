//
//  MainTabBarCell.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit

final class MainTabBarCell: BaseCollectionViewCell {
  
  private var tabView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    tabView = UIImageView.new {
      $0.contentMode = .scaleAspectFit
    }
    
    contentView.addSubview(tabView)
    
    tabView.snp.makeConstraints { make in
      make.top.leading.equalToSuperview().offset(20)
      make.bottom.trailing.equalToSuperview().offset(-20)
    }
  }
  
  func configureCell(with model: UIModel) {
    guard model.type != .share else { return }
    tabView.image = UIImage(named: model.imageName)
    tabView.tintColor = model.tintColor
  }
}

extension MainTabBarCell {
  
  struct UIModel {
    
    let type: MainTabBarViewController.TabBarItem
    
    var isSelected: Bool
    
    var tintColor: UIColor {
      guard isSelected else { return UIColor.systemGray }
      return AppColor.primaryColor
    }
    
    var rawString: String {
      switch type {
      case .home:
        return "home"
      case .search:
        return "search"
      case .share:
        return "share"
      case .chats:
        return "chats"
      case .profile:
        return "profile"
      }
    }
    
    var imageName: String {
      guard isSelected else { return "tabbar_\(rawString)_ic" }
      return "tabbar_\(rawString)_fill_ic"
    }
    
    static func getCells(selectedCell: MainTabBarViewController.TabBarItem) -> [UIModel] {
      let cells = [
        UIModel(type: .home, isSelected: false),
        UIModel(type: .search, isSelected: false),
        UIModel(type: .share, isSelected: false),
        UIModel(type: .chats, isSelected: false),
        UIModel(type: .profile, isSelected: false)
      ]
      
      return cells.compactMap({ cell -> UIModel in
        if cell.type == selectedCell && cell.type != .share {
          return UIModel(type: cell.type, isSelected: true)
        }
        
        return UIModel(type: cell.type, isSelected: false)
      })
    }
  }
}
