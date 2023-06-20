//
//  SignInViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 19.06.23.
//

import Foundation
import Combine

final class SignInViewModel {
  
  var signInButtonTappedSubject = PassthroughSubject<Void, Never>()
  var cancellables = Set<AnyCancellable>()
  
  init() {
    
    setupBinds()
  }
  
  func setupBinds() {
    
    signInButtonTappedSubject
      .sink {
        print("tapped")
      }
      .store(in: &cancellables)
  }
}
