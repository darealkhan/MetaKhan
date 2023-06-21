//
//  UIView+New.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import UIKit

protocol Newable { init() }

extension NSObject: Newable { }
extension Newable where Self: NSObject {
  static func new(_ function: (Self) -> Void) -> Self {
    let instance = self.init()
    function(instance)
    return instance
  }
}

extension Newable where Self: UIButton {
  static func new(type: UIButton.ButtonType, _ function: (Self) -> Void) -> Self {
    let instance = self.init(type: type)
    function(instance)
    return instance
  }
}
