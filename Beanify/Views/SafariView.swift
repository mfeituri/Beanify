//
//  SafariView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/26/25.
//


// this screen displays the auth screen with spotify directly inside app so it doesnt take users out
// wrappable to help with presenting the auth screen inside my app
// wraps uikit in swift ui
import Foundation
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable{
    var url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let safariVC = SFSafariViewController(url: url)
        return safariVC
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
}
