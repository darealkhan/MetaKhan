//
//  SharePostViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 21.06.23.
//

import Foundation
import UIKit
import SnapKit

final class SharePostViewController: BaseViewController {
  
  private var placeHolder: UILabel!
  private var textView: SharePostTextView!
  private var shareButton: PrimaryButton!
  private var keyboardHandler: KeyboardHandler!
  
  override var navigationBarTitle: String { return "Share Post"}
  override var isPresented: Bool { return true }
  override var isTabBarAvailable: Bool { return true }
  override var isTouchDimissKeyboard: Bool { return false }
  
  private var viewModel = SharePostViewModel()
  
  override func setupViews() {
    
    placeHolder = UILabel.new {
      $0.text = "Say something about your thougts 🧐"
      $0.font = AppFont.poppins(ofSize: 12, weight: .regular)
      $0.textColor = .secondaryLabel
    }
    
    keyboardHandler = KeyboardHandler()
    keyboardHandler.delegate = self
    
    textView = SharePostTextView()
    shareButton = PrimaryButton(title: "Share 🤩")
    
    view.addSubViews([
      placeHolder,
      textView,
      shareButton
    ])
    
    placeHolder.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    textView.snp.makeConstraints { make in
      make.top.equalTo(placeHolder.snp.bottom).offset(24)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(100)
    }
    
    shareButton.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  override func setupBinds() {
    
    textView.textViewChangedSubject
      .sink { [weak self] newValue in
        guard let self = self else { return }
        self.viewModel.textViewChangedSubject.send(newValue)
      }.store(in: &cancellables)
    
    shareButton.buttonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.viewModel.shareButtonTappedSubject.send(())
      }.store(in: &cancellables)
  }
}

extension SharePostViewController: KeyboardHandlerDelegate {
  func keyboardWillShow(bottomOffset: CGFloat, animationDuration: Double) {
    UIView.animate(withDuration: animationDuration) {
      self.shareButton.snp.updateConstraints { make in
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-bottomOffset)
      }
      
      self.view.layoutIfNeeded()
    }
  }
  
  func keyboardWillHide(animationDuration: Double) {
    UIView.animate(withDuration: animationDuration) {
      self.shareButton.snp.updateConstraints { make in
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      }
      
      self.view.layoutIfNeeded()
    }
  }
}
