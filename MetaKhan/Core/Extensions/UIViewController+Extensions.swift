//
//  UIViewController+Extensions.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import SkeletonView
import UIKit

extension UIViewController {
  
  func startSkeletoning(_ views: [UIView]) {
    
    DispatchQueue.main.async {
      for view in views {
        view.isUserInteractionEnabled = false
        view.showSkeleton()
        view.showAnimatedGradientSkeleton()
      }
    }
  }
  
  func stopSkeletoning(_ views: [UIView]) {
    
    DispatchQueue.main.async {
      for view in views {
        view.isUserInteractionEnabled = true
        view.hideSkeleton()
        view.stopSkeletonAnimation()
      }
    }
  }
}
