//
//  UserStatusView.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import SwiftUI

struct UserStatusView: View {
    // TODO: Add a user
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            SignInBackgroundView()
            VStack {
                // TODO: Show the current user, if one is signed in

                // TODO: Show the Sign In view is no one is signed in
            }
            .padding()
        }
    }
}

// MARK: - Dismiss Button
struct DismissButton: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button { presentationMode.wrappedValue.dismiss() }
        label: {
            Image(systemName: "xmark.circle.fill")
                .font(.largeTitle)
        }
        .padding()
    }
}
