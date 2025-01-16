//
//  BaseViewController.swift
//  Nupi
//
//  Created by Dana Lim on 1/16/25.
//

import UIKit

class CustomTabBar: UITabBar {
    private let customHeight: CGFloat = 103

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = customHeight
        return sizeThatFits
    }
}

class BaseViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CustomTabBar 설정
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")

        // 다른 설정
        setupTabBarAppearence()
        setupViewControllers()
    }
    
    private func setupViewControllers(){
         let homeVC = HomeViewController()
         let routeVC = RouteViewController()
         let myPageVC = MyPageViewController()
         let scheduleVC = ScheduleViewController()
        
        homeVC.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), tag: 0)
        routeVC.tabBarItem = UITabBarItem(title: "경로", image: UIImage(systemName: "map"), tag: 1)
        scheduleVC.tabBarItem = UITabBarItem(title: "일정", image: UIImage(systemName: "calendar"), tag: 2)
        myPageVC.tabBarItem = UITabBarItem(title: "마이", image: UIImage(systemName: "person"), tag: 3)
        
        self.viewControllers = [homeVC, routeVC, scheduleVC, myPageVC]
    }
    
    // 탭바 스타일 설정
    private func setupTabBarAppearence(){
        let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.tabBar1
            
            // 일반 상태의 글자와 아이콘 색상
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
                .foregroundColor: UIColor.icon2,
                .font: UIFont.tabbar1
            ]
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.icon2
            
            // 선택된 상태의 글자와 아이콘 색상
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
                .foregroundColor: UIColor.icon1,
                .font: UIFont.tabbar1
            ]
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor.icon1
            
            // 탭바에 적용
            tabBar.standardAppearance = appearance
            
            // iOS 15 이상에서는 scrollEdgeAppearance도 설정
            if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
            }
    }

}
