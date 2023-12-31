//
//  UIStackView+Extensions.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: [UIView]) {
    for view in views {
      self.addArrangedSubview(view)
    }
  }
}

