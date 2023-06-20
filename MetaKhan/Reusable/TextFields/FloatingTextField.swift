//
//  FloatingTextField.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class FloatingTextField: UIView {
  
  private let textChangedSubject = PassthroughSubject<String, Never>()
  
  private var stackView: UIStackView!
  private var placeHolder: UILabel!
  private var textField: UITextField!
  
  override init(frame: CGRect) {
    
    super.init(frame: frame)
    
    setupViews()
    setupGestures()
  }
  
  override func layoutSubviews() {
    
    super.layoutSubviews()
    
    setupLayoutViews()
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupViews() {
    
    stackView = UIStackView.new {
      $0.axis = .vertical
      $0.alignment = .leading
      $0.distribution = .equalSpacing
    }
    
    placeHolder = UILabel.new {
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.textColor = .label
    }
    
    textField = UITextField.new {
      $0.autocapitalizationType = .none
      $0.autocorrectionType = .no
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
      $0.textColor = .label
      $0.isHidden = true
    }
    
    textField.delegate = self
    
    stackView.addArrangedSubviews([
      placeHolder,
      textField
    ])
    
    textField.snp.makeConstraints { make in
      make.width.equalToSuperview()
    }
    
    addSubViews([
      stackView
    ])
    
    stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-16)
      make.top.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().offset(-10)
    }
  }
  
  private func setupGestures() {
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTextfield))
    addGestureRecognizer(tapGesture)
  }
  
  private func setupLayoutViews() {
    
    layer.cornerRadius = 12
    layer.masksToBounds = true
    backgroundColor = .systemGray4
  }
  
  @objc private func textFieldChanged() {
    
    guard let text = textField.text else { return }
    textChangedSubject.send(text)
  }

  @objc private func showTextfield() {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .transitionCrossDissolve) {
      self.textField.isHidden = false
      self.textField.becomeFirstResponder()
    }
    UIView.transition(with: placeHolder, duration: 0.3, options: .transitionCrossDissolve) {
      self.placeHolder.font = AppFont.poppins(ofSize: 12, weight: .regular)
    }
  }
  
  private func hideTextField() {
    
    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
      self.textField.isHidden = true
    }
    UIView.transition(with: placeHolder, duration: 0.3, options: .transitionCrossDissolve) {
      self.placeHolder.font = .systemFont(ofSize: 14)
    }
  }
  
  func setupTextField(with config: Configuration) {
    
    placeHolder.text = config.label
  }
  
  override var intrinsicContentSize: CGSize {
    
    return CGSize(width: 0, height: 56)
  }
}

extension FloatingTextField: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    guard let text = textField.text, text.isEmpty else { return }
    hideTextField()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return false
  }
}

extension FloatingTextField {
  struct Configuration {
    
    let label: String
  }
}
