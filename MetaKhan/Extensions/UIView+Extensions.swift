//
//  UIView+Extensions.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import UIKit

extension UIView {
  func addSubViews(_ views: [UIView]) {
    for view in views {
      self.addSubview(view)
    }
  }
}
