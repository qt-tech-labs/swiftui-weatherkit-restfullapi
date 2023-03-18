//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Trung Nguyễn on 3/16/23.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        //Use this if NavigationBarTitle is with Large Font
                UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
                //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().backgroundColor = UIColor(Color.ui.primary)
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
