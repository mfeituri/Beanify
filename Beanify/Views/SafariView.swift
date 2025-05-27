//
//  SafariView.swift
//  Beanify
//
//  Created by Mohamed Feituri on 5/26/25.
//

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
