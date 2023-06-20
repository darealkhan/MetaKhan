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
  
  private var emailTextField: FloatingTextField!
  private var passwordTextField: SecureFloatingTextField!
  private var signInButton: PrimaryButton!
  
  private var viewModel = SignInViewModel()
  
  override func setupViews() {
    
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
    
    signInButton = PrimaryButton(title: "Sign in")
    
    view.addSubViews([
      titleLabel,
      subtitleLabel,
      emailTextField,
      passwordTextField,
      signInButton
    ])
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
    }
    
    signInButton.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
  
  override func setupBinds() {
    
    signInButton.buttonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.viewModel.signInButtonTappedSubject.send(())
      }
      .store(in: &cancellables)
  }
  
  override func startLoading() {
    
    emailTextField.showAnimatedGradientSkeleton()
    passwordTextField.showAnimatedGradientSkeleton()
    signInButton.showAnimatedGradientSkeleton()
  }
  
  override func stopLoading() {
    
    emailTextField.stopSkeletonAnimation()
  }
}
