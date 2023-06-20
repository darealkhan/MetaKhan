//
//  ButtonWithLabel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import Combine

final class ButtonWithLabel: UITextView {
  
  let buttonTappedSubject = PassthroughSubject<Void, Never>()
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    
    super.init(frame: frame, textContainer: textContainer)
  }
  
  convenience init(text: String, actionText: String, fontSize: CGFloat = 12) {
    
    self.init(frame: .zero, textContainer: nil)
    
    delegate = self
    isEditable = false
    isScrollEnabled = false
    
    textContainer.lineFragmentPadding = 0.0
    textContainerInset = .zero
    
    tintColor = AppColor.primaryColor
    
    attributedText = attributedString(with: text, actionText: actionText, fontSize: fontSize)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  private func attributedString(
    with text: String,
    actionText: String,
    fontSize: CGFloat
  ) -> NSMutableAttributedString {
    
    let linkRange = (text as NSString).range(of: actionText)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: AppFont.poppins(ofSize: fontSize, weight: .regular),
      .foregroundColor: UIColor.secondaryLabel
    ]
    
    // Actual Link!
    let linkTextAttributes: [NSAttributedString.Key: Any] = [
      .font: AppFont.poppins(ofSize: fontSize, weight: .medium),
      .link: "",
    ]
    
    let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
    attributedString.addAttributes(linkTextAttributes, range: linkRange)
    
    return attributedString
  }
}

extension ButtonWithLabel: UITextViewDelegate {
  override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false
  }
  
  func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
    buttonTappedSubject.send(())
    return false
  }
}
