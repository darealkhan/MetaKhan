//
//  MainTabBarViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit

final class MainTabBarViewController: UITabBarController {

  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupViews()
  }
  
  private func setupViews() {
    
    let tabBarView = MainTabBarView()
    let spaceOnBottom = UIView.new {
      $0.backgroundColor = .systemBackground
    }
    
    view.addSubViews([
      tabBarView,
      spaceOnBottom
    ])
    
    tabBarView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalToSuperview()
    }
    
    spaceOnBottom.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.bottom.leading.trailing.equalToSuperview()
    }
  }
}
