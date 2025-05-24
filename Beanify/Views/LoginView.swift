//
//  LoginView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/23/25.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @State var viewModel = LoginViewModel()
    var body: some View {
        Button(action: viewModel.startLogin){
            Text("Sign in with Spotify")
        }
        
    }
    
    
    
}
#Preview {
    LoginView()
}

