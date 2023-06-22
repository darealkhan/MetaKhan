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
  var isTabBarAvailable: Bool { get }
  var isPresented: Bool { get }
  
  func setupViews()
  func setupBinds()
  
  func startLoading()
  func stopLoading()
  
  func touchDismissKeyboard()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
  
  var navigationBarTitle: String { return "" }
  var isNavigationBarSeperatorAvailable: Bool { return true }
  var isTabBarAvailable: Bool { return false }
  var isPresented: Bool { return false }
  var isTouchDimissKeyboard: Bool { return true }
  
  var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViewAppearance()
    setupViews()
    setupBinds()
    if isTouchDimissKeyboard { touchDismissKeyboard() }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    setupNavigationBar()
    setupTabBar()
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
    
    let leftInset: CGFloat = isPresented ? 0 : 2
    let imageName: String = isPresented ? "app_close_ic" : "app_back_ic"
    let backImage = UIImage(named: imageName)?
      .withInset(UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: 0))

    navigationController?.navigationBar.tintColor = .label
    
    let appearance = UINavigationBarAppearance()
    if isPresented {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(dismissView))
    } else {
      appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)
    }
    appearance.backgroundColor = .systemBackground
    appearance.titleTextAttributes = [
      NSAttributedString.Key.font: AppFont.poppins(ofSize: 16, weight: .medium)
    ]
    
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
  
  private func setupTabBar() {
    var notification: NSNotification.Name {
      guard isTabBarAvailable else { return .hideTab }
      return .showTab
    }
    
    NSNotification.post(name: notification)
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
  
  @objc private func dismissView() {
    dismiss(animated: true)
  }
}
