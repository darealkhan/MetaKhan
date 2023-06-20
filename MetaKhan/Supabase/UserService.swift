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
}

final class UserService: UserServiceType {
  private let manager = SupabaseManager()
  
  func signIn(with email: String, password: String) async -> SignInPartialState {
    do {
      let result = try await manager.client.auth
        .signIn(email: email, password: password)
      print(result.user.id)
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
}
