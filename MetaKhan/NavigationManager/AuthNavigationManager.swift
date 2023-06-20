//
//  AuthNavigationManager.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit

extension BaseNavigationManager {
  struct Auth: NavigationManagerProtocol {
    static var navigationController: UINavigationController? {
      return BaseNavigationManager.shared.getNavigationController()
    }
    
    static func pushSignUp() {
      let signUp = UIViewController()
      signUp.view.backgroundColor = .yellow
      navigationController?.pushViewController(signUp, animated: true)
    }
  }
}
