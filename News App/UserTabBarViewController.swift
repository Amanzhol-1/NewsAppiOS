//
//  UserTabBarViewController.swift
//  News App
//
//  Created by Сырлыбай Рамазан on 23.02.2024.
//

import UIKit

class UserTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
            super.viewDidLoad()

            
            self.delegate = self

            configureTabs()
        }
    
    private func configureTabs(){
        let vc1 = ViewController()
        let vc2 = FavouriteViewController()

        let vc4 = ProfileViewController()
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc1.title = "Home"
        vc2.tabBarItem.title = "Favourite"
        
        vc4.title = "profile"
        vc4.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        
        let nav4 = UINavigationController(rootViewController: vc4)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray
        
        setViewControllers([nav1, nav2], animated: true)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            if let selectedNav = viewController as? UINavigationController {
                if let selectedVC = selectedNav.viewControllers.first {
                    // Определите текущий класс контроллера и вызовите нужную функцию
                    if selectedVC is FavouriteViewController {
                        // Вызовите функцию для FavouriteViewController
                        (selectedVC as? FavouriteViewController)?.reloadNews()
                    }
                }
            }
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
