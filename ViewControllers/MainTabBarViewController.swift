//
//  MainTabBarViewController.swift
//  Invest
//
//  Created by Max Mikhalskiy on 08.02.2020.
//  Copyright © 2020 Max Mikhalskiy. All rights reserved.
//

import UIKit


class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let mainVC = MainViewController()
        mainVC.tabBarItem = UITabBarItem(title: "Карта", image: UIImage(named: "icon.png"), tag: 0)
        let regionVC = RegionViewController()
        regionVC.tabBarItem = UITabBarItem(title: "Инвестиции в ЛО", image: UIImage(named: "icon.png"), tag: 1)
        let registryVC = RegistryProjectsViewController()
        registryVC.tabBarItem = UITabBarItem(title: "Реестр инвестиционных проектов", image: UIImage(named: "icon.png"), tag: 2)
        let tabBarList = [mainVC, regionVC, registryVC]
        viewControllers = tabBarList.map {
        UINavigationController(rootViewController: $0)
        }
        
    }

}
