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
    
    static func presentSharePost() {
      let sharePost = BaseNavigationController(rootViewController: SharePostViewController())
      sharePost.modalPresentationStyle = .overFullScreen
      navigationController?.present(sharePost, animated: true)
    }
    
    static func dismissPresentedView() {
      DispatchQueue.main.async {
        navigationController?.dismiss(animated: true)
      }
    }
  }
}
