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
  
  var signInButtonTappedSubject = PassthroughSubject<Void, Never>()
  
  override init() {
    
    super.init()
    
    setupBinds()
  }
  
  override func setupBinds() {
    
    signInButtonTappedSubject
      .sink {
        BaseNavigationManager.Auth.pushSignUp()
      }
      .store(in: &cancellables)
  }
}
