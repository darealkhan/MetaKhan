//
//  SecureFloatingTextField.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine
import SkeletonView

final class SecureFloatingTextField: UIView {
  
  private let textChangedSubject = PassthroughSubject<String, Never>()
  
  private var stackView: UIStackView!
  private var placeHolder: UILabel!
  private var textField: UITextField!
  
  private var secureToggleButton: UIButton!
  
  private var isSecure: Bool = true
  
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
    isSkeletonable = true
    
    stackView = UIStackView.new {
      $0.axis = .vertical
      $0.alignment = .leading
      $0.distribution = .equalSpacing
    }
    
    placeHolder = UILabel.new {
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.textColor = .systemGray
    }
    
    textField = UITextField.new {
      $0.autocapitalizationType = .none
      $0.autocorrectionType = .no
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
      $0.textColor = .label
      $0.isSecureTextEntry = isSecure
      $0.isHidden = true
    }
    
    secureToggleButton = UIButton(type: .system)
    secureToggleButton.setImage(UIImage(named: "textField_eye_ic"), for: .normal)
    secureToggleButton.tintColor = .systemGray
    secureToggleButton.addTarget(self, action: #selector(secureToggleTapped), for: .touchUpInside)
    
    textField.delegate = self
    
    stackView.addArrangedSubviews([
      placeHolder,
      textField
    ])
    
    textField.snp.makeConstraints { make in
      make.width.equalToSuperview()
    }
    
    addSubViews([
      stackView,
      secureToggleButton
    ])
    
    stackView.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().offset(-50)
      make.top.equalToSuperview().offset(10)
      make.bottom.equalToSuperview().offset(-10)
    }
    
    secureToggleButton.snp.makeConstraints { make in
      make.trailing.equalToSuperview().offset(-16)
      make.width.height.equalTo(20)
      make.centerY.equalToSuperview()
    }
  }
  
  private func setupGestures() {
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showTextfield))
    addGestureRecognizer(tapGesture)
  }
  
  private func setupLayoutViews() {
    
    layer.cornerRadius = 12
    layer.masksToBounds = true
    backgroundColor = .systemGray6
  }
  
  @objc private func textFieldChanged() {
    
    guard let text = textField.text else { return }
    textChangedSubject.send(text)
  }
  
  @objc private func secureToggleTapped() {
    
    isSecure.toggle()
    textField.isSecureTextEntry = isSecure
    
    switch isSecure {
    case true:
      secureToggleButton.setImage(UIImage(named: "textField_eye_ic"), for: .normal)
    case false:
      secureToggleButton.setImage(UIImage(named: "textField_eye_crossed_ic"), for: .normal)
    }
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

extension SecureFloatingTextField: UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    
    guard let text = textField.text, text.isEmpty else { return }
    hideTextField()
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    return false
  }
}

extension SecureFloatingTextField {
  struct Configuration {
    
    let label: String
  }
}

