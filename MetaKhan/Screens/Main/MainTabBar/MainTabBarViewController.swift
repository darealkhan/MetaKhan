//
//  MainTabBarViewController.swift
//  MetaKhan
//
//  Created by Ayxan Seferli on 20.06.23.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class MainTabBarViewController: UITabBarController {
  
  private var tabBarView: MainTabBarView!
  private var spaceOnBottom: UIView!
  private var cancellables = Set<AnyCancellable>()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupBinds()
  }
  
  private func setupViews() {
    let firstVC = UINavigationController(rootViewController: HomeViewController())
    let secondVC = UINavigationController(rootViewController: HomeViewController())
    let thirdVC = UINavigationController(rootViewController: HomeViewController())
    let fourthVC = UINavigationController(rootViewController: HomeViewController())
    
    viewControllers = [
      firstVC,
      secondVC,
      thirdVC,
      fourthVC
    ]
    
    NavigationManager.shared.setNavigationController(firstVC)
    
    tabBar.isHidden = true
    
    spaceOnBottom = UIView.new {
      $0.backgroundColor = .systemBackground
    }
    tabBarView = MainTabBarView()
    
    view.addSubViews([
      tabBarView,
      spaceOnBottom,
    ])
    
    tabBarView.snp.makeConstraints { make in
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(60)
    }
    
    spaceOnBottom.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom)
      make.bottom.leading.trailing.equalToSuperview()
    }
  }
  
  private func hideTabBar() {
    UIView.transition(with: tabBarView, duration: 0.25, options: .transitionCrossDissolve) {
      self.tabBarView.layer.opacity = 0
    }
    
    UIView.transition(with: spaceOnBottom, duration: 0.25, options: .transitionCrossDissolve) {
      self.spaceOnBottom.layer.opacity = 0
    }
  }
  
  private func showTabBar() {
    UIView.transition(with: tabBarView, duration: 0.25, options: .transitionCrossDissolve) {
      self.tabBarView.layer.opacity = 1
    }
    
    UIView.transition(with: spaceOnBottom, duration: 0.25, options: .transitionCrossDissolve) {
      self.spaceOnBottom.layer.opacity = 1
    }
  }
  
  private func setupBinds() {
    tabBarView.tabChangedSubject
      .sink { [weak self] selectedItem in
        guard let self = self else { return }
        self.handleTabBarChange(with: selectedItem)
      }.store(in: &cancellables)
    
    tabBarView.shareButtonTappedSubject
      .sink {
        NavigationManager.Main.presentSharePost()
      }.store(in: &cancellables)
    
    NotificationCenter.default.publisher(for: .showTab, object: nil)
      .sink { [weak self] _ in
        guard let self = self else { return }
        showTabBar()
      }.store(in: &cancellables)
    
    NotificationCenter.default.publisher(for: .hideTab, object: nil)
      .sink { [weak self] _ in
        guard let self = self else { return }
        hideTabBar()
      }.store(in: &cancellables)
  }
  
  private func handleTabBarChange(with item: TabBarItem) {
    selectedIndex = item.rawValue
    guard let controllers = viewControllers else { return }
    let controller = controllers[selectedIndex] as! UINavigationController
    NavigationManager.shared.setNavigationController(controller)
  }
}

extension MainTabBarViewController {
  
  enum TabBarItem: Int {
    case home
    case search
    case share
    case chats
    case profile
  }
}
