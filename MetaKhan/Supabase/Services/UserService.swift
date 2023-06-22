//
//  UserService.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import Supabase

protocol UserServiceType {
  func signIn(with email: String, password: String) async -> UserService.SignInPartialState
  func signUp(with email: String, password: String) async -> UserService.SignUpPartialState
}

final class UserService: UserServiceType {
  private var manager = SupabaseManager()
  
  func signIn(with email: String, password: String) async -> SignInPartialState {
    do {
      let _ = try await manager.client.auth
        .signIn(email: email, password: password)
      
      return .success
    } catch {
      return .failure
    }
  }
  
  func signUp(with email: String, password: String) async -> SignUpPartialState {
    do {
      let _ = try await manager.client.auth
        .signUp(email: email, password: password, redirectTo: nil)
      
      return .success
    } catch {
      return .failure
    }
  }
}

extension UserService {
  enum SignInPartialState {
    case success
    case failure
  }
  
  enum SignUpPartialState {
    case success
    case failure
  }
}
