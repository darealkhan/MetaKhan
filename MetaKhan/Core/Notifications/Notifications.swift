//
//  Notifications.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 21.06.23.
//

import Foundation

public extension NSNotification {
  static func post(
    name: NSNotification.Name,
    data: [AnyHashable: Any]? = nil
  ) {
    NotificationCenter.default.post(name: name, object: nil, userInfo: data)
  }
}

public extension NSNotification.Name {
  static let showTab = NSNotification.Name("showTab")
  static let hideTab = NSNotification.Name("hideTab")
}
