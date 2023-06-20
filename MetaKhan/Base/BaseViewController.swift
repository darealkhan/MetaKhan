//
//  BaseViewController.swift
//  MetaKhan
//
//  Created by Ayxan Səfərli on 20.06.23.
//

import Foundation
import UIKit
import Combine

protocol BaseViewControllerProtocol {
  
  var navigationBarTitle: String { get }
  var isNavigationBarSeperatorAvailable: Bool { get }
  
  func setupViews()
  func setupBinds()
  
  func startLoading()
  func stopLoading()
  
  func touchDismissKeyboard()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
  
  var navigationBarTitle: String { return "" }
  var isNavigationBarSeperatorAvailable: Bool { return false }
  
  var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    setupViewAppearance()
    setupViews()
    setupBinds()
    touchDismissKeyboard()
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
    
    title = navigationBarTitle
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "",
      style: .plain,
      target: nil,
      action: nil
    )
    
    let backImage = UIImage(named: "app_back_ic")?
      .withInset(UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0))

    navigationController?.navigationBar.tintColor = .label
    navigationController?.navigationBar.titleTextAttributes = [
      NSAttributedString.Key.font: AppFont.poppins(ofSize: 14, weight: .medium)
    ]
    
    let appearance = UINavigationBarAppearance()
    appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
    appearance.backgroundColor = .systemBackground
    
    if isNavigationBarSeperatorAvailable {
      appearance.configureWithOpaqueBackground()
    } else {
      appearance.configureWithTransparentBackground()
    }
    
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
  }
  
  func setupViews() {}
  func setupBinds() {}
  
  func startLoading() {}
  func stopLoading() {}
  
  func touchDismissKeyboard() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTouched))
    self.view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func viewTouched() {
    KeyboardHandler.hideKeyboard()
  }
}
