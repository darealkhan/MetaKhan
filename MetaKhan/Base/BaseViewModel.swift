//
//  BaseViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
  
  func setupBinds()
}

class BaseViewModel: BaseViewModelProtocol {
  
  var cancellables = Set<AnyCancellable>()
  
  func setupBinds() {}
  
  deinit {
    cancellables = []
  }
}
