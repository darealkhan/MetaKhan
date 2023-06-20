//
//  SignInViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine
import SkeletonView

final class SignInViewController: BaseViewController {
  
  private var scrollView = AppScrollView()
  
  private var emailTextField: FloatingTextField!
  private var passwordTextField: SecureFloatingTextField!
  private var signUpButton: ButtonWithLabel!
  private var signInButton: PrimaryButton!
  
  private var viewModel = SignInViewModel()
  
  override func setupViews() {
    
    scrollView = AppScrollView()
    
    let titleLabel = UILabel.new {
      $0.text = "Welcome back!"
      $0.font = AppFont.poppins(ofSize: 24, weight: .bold)
      $0.textColor = .label
    }
    
    let subtitleLabel = UILabel.new {
      $0.text = "Sign in to MetaKhan and start meeting new people, exploring new things, sharing your own moments and etc. 🤪"
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
    
    signUpButton = ButtonWithLabel(text: "Don't have account? Sign Up!", actionText: "Sign Up!")
    
    signInButton = PrimaryButton(title: "Sign in")
    
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
      make.top.equalToSuperview()
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
    
    signUpButton.snp.makeConstraints { make in
      make.bottom.equalTo(signInButton.snp.top).offset(-16)
      make.centerX.equalToSuperview()
    }
    
    signInButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
  
  override func setupBinds() {
    
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
      signInButton
    ])
  }
  
  override func stopLoading() {
    
    stopSkeletoning([
      emailTextField,
      passwordTextField,
      signInButton
    ])
  }
}
