//
//  MainNavigationManager.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 21.06.23.
//

import Foundation
import UIKit

extension NavigationManager {
  struct Main: NavigationManagerProtocol {
    static var navigationController: UINavigationController? {
      return NavigationManager.shared.getNavigationController()
    }
  }
}
