//
//  BaseViewModel.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {
  var startLoadingSubject: PassthroughSubject<Void, Never> { get }
  var stopLoadingSubject: PassthroughSubject<Void, Never> { get }
  
  func setupBinds()
  func startLoading()
  func stopLoading()
}

class BaseViewModel: BaseViewModelProtocol {
  var startLoadingSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
  var stopLoadingSubject: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()
  
  var cancellables = Set<AnyCancellable>()
  
  init() {
    setupBinds()
  }
  
  func setupBinds() {}
  
  func startLoading() {
    startLoadingSubject.send(())
  }
  
  func stopLoading() {
    stopLoadingSubject.send(())
  }
  
  deinit {
    cancellables = []
  }
}
