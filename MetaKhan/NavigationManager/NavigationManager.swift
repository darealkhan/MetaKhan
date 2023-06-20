//
//  BaseNavigationManager.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit

protocol NavigationManagerProtocol {
  static var navigationController: UINavigationController? { get }
}

struct NavigationManager {
  static var shared = NavigationManager()
  
  var window: UIWindow?
  var navigationController: UINavigationController?
  
  mutating func setWindow(_ window: UIWindow) {
    self.window = window
  }
  
  mutating func setNavigationController(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  mutating func changeRoot(with controller: UINavigationController) {
    window?.rootViewController = controller
    window?.makeKeyAndVisible()
    self.navigationController = controller
  }
  
  func getNavigationController() -> UINavigationController? {
    return navigationController
  }
}
