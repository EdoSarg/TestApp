//
//  CustomTabBarViewController.swift
//  testTask
//
//  Created by Edgar Sargsyan on 21.10.23.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc_1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page2") as! Page2
        let vc_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Page3") as! Page3
        let nav1 = generateController(vc: vc_1, icon: UIImage(named: "Calculator")!, title: "")
        let nav2 = generateController(vc: vc_2, icon: UIImage(named: "activity")!, title: "Tride")
        
        UINavigationBar.appearance().prefersLargeTitles = false
        tabBar.tintColor = UIColor.green
        viewControllers = [nav2, nav1]
        selectedIndex = 1
    }
    
    private func generateController(vc: UIViewController, icon: UIImage, title: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = icon
        return navController
    }
}
