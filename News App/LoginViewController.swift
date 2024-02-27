//
//  LoginViewController.swift
//  News App
//
//  Created by Сырлыбай Рамазан on 24.02.2024.
//
import UIKit

class LoginViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
        configureNavigationBar()
    }
    
    private func configureTabs() {
        let homeVC = ViewController()
        let loginVC = JoinViewController()

        homeVC.tabBarItem.image = UIImage(systemName: "house.circle")
        loginVC.tabBarItem.image = UIImage(systemName: "person")

        homeVC.title = "Home"
        loginVC.tabBarItem.title = "Login"

        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: loginVC)

        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray

        setViewControllers([nav1, nav2], animated: true)
    }

    private func configureNavigationBar() {
        // Устанавливаем цвет фона навигационной панели
        navigationController?.navigationBar.barTintColor = .systemGray
        // Устанавливаем цвет текста на навигационной панели
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        // Добавляем кнопку "Back"
        let backButton = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBack))
        backButton.tintColor = .label
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
