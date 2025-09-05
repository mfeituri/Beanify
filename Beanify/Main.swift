//
//  BeanifyApp.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/19/25.
//

import SwiftUI
import SpotifyiOS

@main
struct Main: App {
    @StateObject var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                .onOpenURL{
                    url in
                    viewModel.handleRedirect(url)
                }
            
        }
    }
}
