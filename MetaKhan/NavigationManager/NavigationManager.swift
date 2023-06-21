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

final class NavigationManager {
  static var shared = NavigationManager()
  
  var window: UIWindow?
  var navigationController: UINavigationController?
  
  func setWindow(_ window: UIWindow) {
    self.window = window
  }
  
  func setNavigationController(_ navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
  
  func changeRoot(with controller: UIViewController) {
    DispatchQueue.main.async {
      self.window?.rootViewController = controller
      self.window?.makeKeyAndVisible()
    }
  }
  
  func pop() {
    navigationController?.popViewController(animated: true)
  }
  
  func getNavigationController() -> UINavigationController? {
    return navigationController
  }
}
