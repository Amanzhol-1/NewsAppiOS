//
//  UserTabBarViewController.swift
//  News App
//
//  Created by Сырлыбай Рамазан on 23.02.2024.
//

import UIKit

class UserTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
    }
    
    private func configureTabs(){
        let vc1 = ViewController()
        let vc2 = FavouriteViewController()
        let vc3 = HeadlinesViewController()
        let vc4 = ProfileViewController()
        vc1.tabBarItem.image = UIImage(systemName: "house.circle")
        vc2.tabBarItem.image = UIImage(systemName: "star")
        vc1.title = "Home"
        vc2.tabBarItem.title = "Favourite"
        
        vc3.title = "headlines"
        vc3.tabBarItem.image = UIImage(systemName: "headlight.high.beam.fill")
        vc4.title = "profile"
        vc4.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        let nav4 = UINavigationController(rootViewController: vc4)
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemGray
        
        setViewControllers([nav1, nav2, nav3, nav4], animated: true)
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
