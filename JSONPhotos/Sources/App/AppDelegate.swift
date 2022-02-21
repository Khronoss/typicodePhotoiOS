//
//  AppDelegate.swift
//  JSONPhotos
//
//  Created by Merle Anthony on 20/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Override point for customization after application launch.
        self.window = Self.createWindow()
        self.window?.makeKeyAndVisible()

        return true
    }

    static func createWindow() -> UIWindow {
        let window = UIWindow()
        let rootCoordinator = AlbumsCoordinator(from: window)

        rootCoordinator.start()

        return window
    }
}
