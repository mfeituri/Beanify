//
//  LoginView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/23/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State var isShowingSafari = false
    @State var viewModel = LoginViewModel()
    var body: some View {
        VStack{
            Button(action: viewModel.startLogin){
                Text("Sign in with Spotify")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: Binding(
                get: {viewModel.authURL != nil},
                set: { if !$0 { viewModel.authURL = nil } }
            )){
                if let url = viewModel.authURL{
                    SafariView(url: url)
                }
            }
        }
    }
    
}
#Preview {
    NavigationStack{
        LoginView()
    }
}


