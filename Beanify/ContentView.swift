//
//  ContentView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username: String = " "
    var body: some View {
        
        Form{
            TextField("Username", text: $username ){
                
                
            }
            
            
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
