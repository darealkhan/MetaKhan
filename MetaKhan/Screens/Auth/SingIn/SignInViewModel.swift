//
//  SignInViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import Foundation
import Combine
import UIKit

final class SignInViewModel: BaseViewModel {
  
  private let service = UserService()
  
  private var email: String = "aykhanseferli@gmail.com"
  private var password: String = "ayxan2004"
  
  var signInButtonTappedSubject = PassthroughSubject<Void, Never>()
  var signUpButtonTappedSubject = PassthroughSubject<Void, Never>()
  var emailChangedSubject = PassthroughSubject<String, Never>()
  var passwordChangedSubject = PassthroughSubject<String, Never>()
  
  override init() {
    super.init()
    
    setupBinds()
  }
  
  override func setupBinds() {
    signInButtonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.signIn()
      }.store(in: &cancellables)
    
    signUpButtonTappedSubject
      .sink {
        NavigationManager.Auth.pushSignUp()
      }.store(in: &cancellables)
    
    emailChangedSubject
      .sink { [weak self] email in
        guard let self = self else { return }
        self.email = email
      }.store(in: &cancellables)
    
    passwordChangedSubject
      .sink { [weak self] password in
        guard let self = self else { return }
        self.password = password
      }.store(in: &cancellables)
  }
  
  func signIn() {
    startLoading()
    
    Task {
      
      let result = await service.signIn(with: email, password: password)
      
      stopLoading()
      
      switch result {
      case .success:
        await NavigationManager.shared.changeRoot(with: MainTabBarViewController())
      case .failure:
        print("failure")
      }
    }
  }
}
