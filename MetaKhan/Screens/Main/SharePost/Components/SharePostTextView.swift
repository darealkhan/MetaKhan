//
//  SharePostTextView.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine
import SkeletonView

final class SharePostTextView: UITextView {
  
  let textViewChangedSubject = PassthroughSubject<String, Never>()
  
  private var shareButton: PrimaryButton!
  
  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    
    setupViews()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    setupAfterLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    becomeFirstResponder()
    delegate = self
    
    isSkeletonable = true
    
    font = AppFont.poppins(ofSize: 16, weight: .regular)
    autocorrectionType = .no
  }
  
  private func setupAfterLayout() {

  }
}

extension SharePostTextView: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    guard let text = textView.text else { return }
    textViewChangedSubject.send(text)
  }
}
