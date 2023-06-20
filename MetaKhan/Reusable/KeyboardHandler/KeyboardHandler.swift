//
//  KeyboardHandler.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit
import Combine

protocol KeyboardHandlerDelegate: AnyObject {
  
  func keyboardWillShow(bottomOffset: CGFloat, animationDuration: Double)
  func keyboardWillHide(animationDuration: Double)
}

final class KeyboardHandler {
  
  weak var delegate: KeyboardHandlerDelegate?
  private let offset: CGFloat
  
  init(offset: CGFloat = 20) {
    
    self.offset = offset
    setupKeyboardNotifications()
  }
  
  deinit {

    removeKeyboardNotifications()
  }
  
  private func setupKeyboardNotifications() {
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShowAction(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHideAction(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func removeKeyboardNotifications() {
    
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  @objc func keyboardWillShowAction(_ notification: Notification) {
    
    let userInfo = notification.userInfo
    let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
    let keyboardHeight = keyboardSize.cgRectValue.height
    let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    let bottomOffset = keyboardHeight + offset
    
    delegate?.keyboardWillShow(bottomOffset: bottomOffset, animationDuration: animationDuration)
  }
  
  @objc func keyboardWillHideAction(_ notification: Notification) {
    
    let userInfo = notification.userInfo
    let animationDuration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
    
    delegate?.keyboardWillHide(animationDuration: animationDuration)
  }
  
  static func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
