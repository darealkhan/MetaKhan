//
//  SignInViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import Foundation
import UIKit
import SnapKit

final class SignInViewController: UIViewController {
  
  private var emailTextField: FloatingTextField!
  private var passwordTextField: FloatingTextField!
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupViews()
  }
  
  private func setupViews() {
    
    view.backgroundColor = .white
    
    let titleLabel = UILabel.new {
      $0.text = "Welcome back!"
      $0.font = .systemFont(ofSize: 24, weight: .bold)
      $0.textColor = .black
    }
    
    let subtitleLabel = UILabel.new {
      $0.text = "Sign in to MetaKhan and start meeting new people, exploring new things, sharing your own moments and etc. 🤪"
      $0.font = .systemFont(ofSize: 14, weight: .regular)
      $0.numberOfLines = 0
      $0.textAlignment = .left
      $0.textColor = .black
      $0.layer.opacity = 0.6
    }
    
    emailTextField = FloatingTextField.new {
      $0.setupTextField(with: FloatingTextField.Configuration(label: "Email"))
    }
    
    passwordTextField = FloatingTextField.new {
      $0.setupTextField(with: FloatingTextField.Configuration(label: "Password"))
    }
    
    view.addSubViews([
      titleLabel,
      subtitleLabel,
      emailTextField,
      passwordTextField
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
    }
    
    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(emailTextField.snp.bottom).offset(16)
      make.leading.equalToSuperview().offset(20)
      make.trailing.equalToSuperview().offset(-20)
    }
  }
}
