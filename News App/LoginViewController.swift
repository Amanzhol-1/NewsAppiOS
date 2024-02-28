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
        // Do any additional setup after loading the view.
    }
    
    private func configureTabs(){
        let vc1 = ViewController()
        let vc2 = JoinViewController()
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "person")
        vc1.title = "Home"
        vc2.tabBarItem.title = "Login"
        
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray
        
        setViewControllers([nav1, nav2], animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
