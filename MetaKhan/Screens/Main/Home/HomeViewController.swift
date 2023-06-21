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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      let vc = UIViewController()
      vc.view.backgroundColor = .yellow
      vc.hidesBottomBarWhenPushed = true
      NavigationManager.Main.pushYellow()
    }
  }
  
  override func setupViews() {
  }
  
  override func setupBinds() {
    
  }
}
