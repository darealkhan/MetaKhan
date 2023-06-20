//
//  BaseViewController.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit
import Combine

class BaseViewController: UIViewController {
  
  var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupViewAppearance()
    setupViews()
    setupBinds()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    super.viewWillAppear(animated)
    
    setupNavigationBar()
  }
  
  deinit {
    cancellables = []
  }
  
  private func setupViewAppearance() {
    
    view.backgroundColor = .systemBackground
  }
  
  private func setupNavigationBar() {
    
  }
  
  func setupViews() {}
  func setupBinds() {}
  
  func startLoading() {}
  func stopLoading() {}
}
