//
//  SceneDelegate.swift
//  HOFlix
//
//  Created by 이찬호 on 6/4/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let tabVC = UITabBarController()
        let trendVC = TrendViewController()
        let trendNav = UINavigationController(rootViewController: trendVC)
        trendNav.isNavigationBarHidden = true
        let searchVC = SearchViewController()
//        let homeVC = HomeViewController()
//        let signupVC = SignUpViewController()
//        let boxVC = BoxOfficeViewController()
//        let lottoVC = LottoViewController()
        searchVC.title = "검색"
        searchVC.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        trendVC.title = "트렌드"
        trendVC.tabBarItem.image = UIImage(systemName: "chart.xyaxis.line")
//        homeVC.title = "홈"
//        signupVC.title = "회원가입"
//        boxVC.title = "박스오피스 조회"
//        lottoVC.title = "로또 번호 조회"
        tabVC.viewControllers = [searchVC,trendNav]
        window?.rootViewController = tabVC
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
