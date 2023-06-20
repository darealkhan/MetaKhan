//
//  TextButton.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import Combine
import SkeletonView

final class TextButton: UIButton {
  
  let buttonTappedSubject = PassthroughSubject<Void, Never>()
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
  }
  
  convenience init(
    title: String,
    fontSize: CGFloat = 14,
    fontWeight: PoppinsFontWeight = .regular
  ) {
    
    self.init(frame: .zero)
    
    titleLabel?.font = AppFont.poppins(ofSize: fontSize, weight: fontWeight)
    
    setTitleColor(AppColor.primaryColor, for: .normal)
    
    setTitle(title, for: .normal)
    
    isSkeletonable = true
    
    addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
}
