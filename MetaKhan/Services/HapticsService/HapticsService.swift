//
//  HapticsService.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 22.06.23.
//

import Foundation
import UIKit

struct HapticsService {
  init() {}
  
  static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
    UIImpactFeedbackGenerator(style: style).impactOccurred()
  }
  
  static func notification(_ notificationType: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(notificationType)
  }
}
