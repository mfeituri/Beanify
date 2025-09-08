//
//  RootView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/27/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    var body: some View{
        
        if viewModel.isLoggedIn{
            NavigationStack{
                TabNavigationView()
            }
        } else {
            LoginView()
        }
        
    }
}
