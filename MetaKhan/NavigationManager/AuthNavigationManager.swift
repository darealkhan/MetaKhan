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
      let signUp = SignInViewController()
      navigationController?.pushViewController(signUp, animated: true)
    }
  }
}
