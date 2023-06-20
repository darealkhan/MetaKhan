//
//  AuthNavigationManager.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit

extension NavigationManager {
  struct Auth: NavigationManagerProtocol {
    static var navigationController: UINavigationController? {
      return NavigationManager.shared.getNavigationController()
    }
    
    static func pushSignUp() {
      let signUp = SignUpViewController()
      navigationController?.pushViewController(signUp, animated: true)
    }
  }
}
