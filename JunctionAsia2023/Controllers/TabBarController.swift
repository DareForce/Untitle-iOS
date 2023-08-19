//
//  TabBarController.swift
//  JunctionAsia2023
//
//  Created by 최지철 on 2023/08/19.
//

import UIKit

class TabBarController: UITabBarController,UITabBarControllerDelegate {

    let mainVC = MainViewController()
//    var allergyDatum: [String]?
//    var disLikeDatum: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.delegate = self
        let vc1 = UINavigationController(rootViewController: RestaurantViewController())
        vc1.tabBarItem.selectedImage = UIImage(systemName: "fork.knife")
        vc1.navigationBar.isHidden = true
        vc1.tabBarItem.image = UIImage(systemName: "fork.knife")

        let vc2 = UINavigationController(rootViewController: mainVC)
        vc2.navigationBar.isHidden = true

        vc2.tabBarItem.image = UIImage(systemName: "lanyardcard.fill")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "lanyardcard.fill")
        let vc3 = UINavigationController(rootViewController: HistoryViewController())
        vc3.navigationBar.isHidden = true

        vc3.tabBarItem.selectedImage = UIImage(systemName: "clock.fill")
        vc3.tabBarItem.image = UIImage(systemName: "clock")
        
   
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = .white
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        self.tabBar.clipsToBounds = true
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.tintColor = UIColor(hexString: "#007AFF")


        
        setViewControllers([vc1,vc2,vc3], animated: false)
    }
}
