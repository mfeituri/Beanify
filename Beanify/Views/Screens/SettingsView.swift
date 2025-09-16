//
//  SettingsView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 8/29/25.
//
import SwiftUI

struct SettingsView: View{
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            List{
                NavigationLink("Profile", value: "Profile")
                NavigationLink("Another Navigation Setting", value: "random")
            }
            
        }
    }
    }
    
    
    #Preview{
        SettingsView()
    }


