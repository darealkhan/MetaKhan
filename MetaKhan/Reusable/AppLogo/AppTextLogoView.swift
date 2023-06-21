//
//  AppTextLogoView.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 21.06.23.
//

import Foundation
import UIKit
import SnapKit

final class AppTextLogoView: UILabel {
  
  private var fontSize: CGFloat
  
  override init(frame: CGRect) {
    self.fontSize = 0
    super.init(frame: frame)
  }
  
  convenience init(fontSize: CGFloat) {
    self.init(frame: .zero)
    self.fontSize = fontSize
    attributedText = attributedString()
    textAlignment = .left
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func attributedString() -> NSMutableAttributedString {
    let text = "MetaKhan"
    let coloredText = "Meta"
    
    let coloredRange = (text as NSString).range(of: coloredText)
    
    let attributes: [NSAttributedString.Key: Any] = [
      .font: AppFont.poppins(ofSize: fontSize, weight: .regular),
      .foregroundColor: UIColor.label
    ]
    
    let coloredTextAttributes: [NSAttributedString.Key: Any] = [
      .font: AppFont.poppins(ofSize: fontSize, weight: .bold),
      .foregroundColor: AppColor.primaryColor
    ]
    
    let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
    attributedString.addAttributes(coloredTextAttributes, range: coloredRange)
    
    return attributedString
  }
}
