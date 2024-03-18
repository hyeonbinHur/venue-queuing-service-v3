//
//  AuthenticationModule.swift
//  MyTable
//
//  Created by Pascal Couturier on 21/8/2023.
//

import Foundation
import SwiftUI

/// The authentication page for initial load and displays a singup or login screen to the user
struct AuthenticationModule: View {
    // Authentication modules
    @State private var isSignup = false
    var body: some View {
        NavigationView {
            // Conditionally show the signup or login views when placed on the page
            if (isSignup) {
                SignUpView(isSignup: $isSignup)
            } else {
                LoginView(isSignup: $isSignup)
            }
        }
    }
}
