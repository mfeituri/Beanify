//
//  DashboardVIew.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/24/25.
//

import Foundation
import SwiftUI

struct DashboardView: View{
    // random tester
    @State private var username = ""
    @State private var password = ""
    var body: some View{
        Form{
            TextField("enter username", text: $username)
            TextField("enter password", text: $password)
            Button("Login"){
                
            }.buttonStyle(.borderless)
        }
    }
}

#Preview {
    DashboardView()
}
