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
    @EnvironmentObject var viewModel: LoginViewModel // use this since im going to pass to multiple views
    var body: some View {
        ZStack{
            RadialGradient(colors: [.green, .purple], center: .center, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack{
                Text("Beanify")
                    .font(
                        .largeTitle
                            .bold()
                    )
                    .foregroundColor(.purple)
                VStack{
                    Image("kitty")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350)
                        .clipped()
                        .blur(radius: 0.5)
                        .mask(
                            RadialGradient(gradient: Gradient(stops: [
                                .init(color: .green, location: 0.1),
                                .init(color: .clear, location: 1.0)
                            ]), center: .center,  startRadius: 100, endRadius: 300
                            )
                      )
                    
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
    }
    
}
#Preview {
    NavigationStack{
        LoginView()
            .environmentObject(LoginViewModel())
    }
}


