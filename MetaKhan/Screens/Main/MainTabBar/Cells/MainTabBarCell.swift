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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    
  }
}

extension MainTabBarCell {
  
  struct UIModel {
    
    let type: MainTabBarViewController.TabBarItem
    
    var isSelected: Bool
    
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
      var cells = [
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
