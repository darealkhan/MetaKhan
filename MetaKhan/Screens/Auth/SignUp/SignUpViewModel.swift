//
//  SignUpViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import Combine
import UIKit

final class SignUpViewModel: BaseViewModel {
  
  private let service = UserService()
  
  private var email: String = ""
  private var password: String = ""
  
  var signInButtonTappedSubject = PassthroughSubject<Void, Never>()
  var signUpButtonTappedSubject = PassthroughSubject<Void, Never>()
  var emailChangedSubject = PassthroughSubject<String, Never>()
  var passwordChangedSubject = PassthroughSubject<String, Never>()
  
  var startLoadingSubject = PassthroughSubject<Void, Never>()
  var stopLoadingSubject = PassthroughSubject<Void, Never>()
  
  override init() {
    
    super.init()
    
    setupBinds()
  }
  
  override func setupBinds() {
    
    signInButtonTappedSubject
      .sink {
        NavigationManager.shared.pop()
      }.store(in: &cancellables)
    
    signUpButtonTappedSubject
      .sink { [weak self] in
        guard let self = self else { return }
        self.signUp()
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
  
  func signUp() {
    
    startLoadingSubject.send(())
    
    Task {
      
      let result = await service.signUp(with: email, password: password)
      
      stopLoadingSubject.send(())
      
      switch result {
      case .success:
        print("success")
      case .failure:
        print("failure")
      }
    }
  }
}
