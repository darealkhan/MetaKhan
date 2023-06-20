//
//  AppButton.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit

final class PrimaryButton: UIButton {
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  convenience init(title: String) {
    
    self.init(frame: .zero)
    
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    titleLabel?.font = AppFont.poppins(ofSize: 16, weight: .semiBold)
    
    backgroundColor = AppColor.primaryColor
    setTitleColor(AppColor.white, for: .normal)
    
    setTitle(title, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  override var isHighlighted: Bool {
    
    get { return super.isHighlighted }
    set {
      guard newValue != isHighlighted else { return }
      
      if newValue == true {
        titleLabel?.alpha = 0.25
      } else {
        UIView.animate(withDuration: 0.25) {
          self.titleLabel?.alpha = 1
        }
        super.isHighlighted = newValue
      }
      
      super.isHighlighted = newValue
    }
  }
  
  override var intrinsicContentSize: CGSize {
    
    return CGSize(width: 0, height: 56)
  }
}
