//
//  PrimaryButton.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit
import Combine
import SkeletonView

final class PrimaryButton: UIButton {
  
  let buttonTappedSubject = PassthroughSubject<Void, Never>()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  convenience init(title: String) {
    
    self.init(frame: .zero)
    
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    titleLabel?.font = AppFont.poppins(ofSize: 16, weight: .semiBold)
    
    backgroundColor = AppColor.primaryColor
    setTitleColor(.white, for: .normal)
    setTitleColor(.systemGray, for: .disabled)
    
    setTitle(title, for: .normal)
    
    isSkeletonable = true
    
    addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  func isDisabled(_ isDisabled: Bool) {
    self.isEnabled = !isDisabled
    
    DispatchQueue.main.async {
      if isDisabled {
        self.backgroundColor = .secondarySystemBackground
      } else {
        self.backgroundColor = AppColor.primaryColor
      }
    }
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc private func buttonTapped() {
    
    buttonTappedSubject.send(())
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
