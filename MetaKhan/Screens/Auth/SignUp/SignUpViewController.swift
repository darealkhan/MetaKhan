//
//  SignUpViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine
import SkeletonView

final class SignUpViewController: BaseViewController {
  
  override var navigationBarTitle: String { return "Sign Up" }
  
  private var scrollView = AppScrollView()
  
  private var emailTextField: FloatingTextField!
  private var passwordTextField: SecureFloatingTextField!
  private var signInButton: ButtonWithLabel!
  private var signUpButton: PrimaryButton!
  
  private var viewModel = SignUpViewModel()
  private var keyboardHandler = KeyboardHandler()
  
  override func setupViews() {
    
    scrollView = AppScrollView()
    
    let titleLabel = UILabel.new {
      $0.text = "Heyy! 🧐"
      $0.font = AppFont.poppins(ofSize: 24, weight: .bold)
      $0.textColor = .label
    }
    
    let subtitleLabel = UILabel.new {
      $0.text = "Why u don't have an account yet? 😱 Sign Up just with your email and password now and enjoy every moment with MetaKhan! 😜"
      $0.font = AppFont.poppins(ofSize: 14, weight: .regular)
      $0.numberOfLines = 0
      $0.textAlignment = .left
      $0.textColor = .secondaryLabel
    }
    
    emailTextField = FloatingTextField.new {
      $0.setupTextField(with: FloatingTextField.Configuration(label: "Email"))
    }
    
    passwordTextField = SecureFloatingTextField.new {
      $0.setupTextField(with: SecureFloatingTextField.Configuration(label: "Password"))
    }
    
    signInButton = ButtonWithLabel(text: "Do you have an account? Sign In!", actionText: "Sign In!")
    
    signUpButton = PrimaryButton(title: "Sign Up")
    
    scrollView.contentView.addSubViews([
      titleLabel,
      subtitleLabel,
      emailTextField,
      passwordTextField
    ])
    
    view.addSubViews([
      scrollView,
      signUpButton,
      signInButton
    ])
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    subtitleLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(10)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
    
    emailTextField.snp.makeConstraints { make in
      make.top.equalTo(subtitleLabel.snp.bottom).offset(36)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(56)
    }
    
    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(emailTextField.snp.bottom).offset(16)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
      make.height.equalTo(56)
      make.bottom.equalToSuperview()
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(signUpButton.snp.top).offset(-16)
    }
    
    signInButton.snp.makeConstraints { make in
      make.bottom.equalTo(signUpButton.snp.top).offset(-16)
      make.centerX.equalToSuperview()
    }
    
    signUpButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
  
  override func setupBinds() {
    
    keyboardHandler.delegate = self
    
    viewModel.startLoadingSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.startLoading()
      }.store(in: &cancellables)
    
    viewModel.stopLoadingSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.stopLoading()
      }.store(in: &cancellables)
    
    signInButton.buttonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.viewModel.signInButtonTappedSubject.send(())
      }.store(in: &cancellables)
    
    signUpButton.buttonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.viewModel.signUpButtonTappedSubject.send(())
      }.store(in: &cancellables)
    
    emailTextField.textChangedSubject
      .sink { [weak self] email in
        guard let self = self else { return }
        self.viewModel.emailChangedSubject.send(email)
      }.store(in: &cancellables)
    
    passwordTextField.textChangedSubject
      .sink { [weak self] password in
        guard let self = self else { return }
        self.viewModel.passwordChangedSubject.send(password)
      }.store(in: &cancellables)
  }
  
  override func startLoading() {
    
    startSkeletoning([
      emailTextField,
      passwordTextField,
      signUpButton
    ])
  }
  
  override func stopLoading() {
    
    stopSkeletoning([
      emailTextField,
      passwordTextField,
      signUpButton
    ])
  }
}

extension SignUpViewController: KeyboardHandlerDelegate {
  func keyboardWillShow(bottomOffset: CGFloat, animationDuration: Double) {
    UIView.animate(withDuration: animationDuration) {
      self.signUpButton.snp.updateConstraints { make in
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-bottomOffset)
      }
      
      self.view.layoutIfNeeded()
    }
  }
  
  func keyboardWillHide(animationDuration: Double) {
    UIView.animate(withDuration: animationDuration) {
      self.signUpButton.snp.updateConstraints { make in
        make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
      }
      
      self.view.layoutIfNeeded()
    }
  }
}
