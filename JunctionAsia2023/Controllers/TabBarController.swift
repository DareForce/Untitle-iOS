//
//  TabBarController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    let mainVC = MainViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        self.tabBarController?.tabBar.tintColor = .red
        self.delegate = self
        let vc1 = UINavigationController(rootViewController: RestaurantViewController())
        vc1.tabBarItem.selectedImage = UIImage(systemName: "fork.knife")
        vc1.tabBarItem.image = UIImage(systemName: "fork.knife")
        
        vc1.title = "Restaurant"

        let vc2 = UINavigationController(rootViewController: mainVC)
        vc2.tabBarItem.image = UIImage(systemName: "lanyardcard.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "lanyardcard.fill")
        vc2.title = "Food ID"
        
        let vc3 = UINavigationController(rootViewController: HistoryViewController())
        vc3.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        vc3.tabBarItem.image = UIImage(systemName: "person.fill")
        vc3.title = "My Data"
        
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        self.tabBar.clipsToBounds = true
        self.tabBar.unselectedItemTintColor = .systemGray
        self.tabBar.tintColor = UIColor(hexString: "#007AFF")


        
        setViewControllers([vc1,vc2,vc3], animated: false)
    }
}
