//
//  UserView.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import SwiftUI

struct CurrentUserView: View {
    // TODO: Add a user
    var anonymous = true

    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 20) {
                if anonymous {
                    Text("""
                        You are currently
                        signed in as a Guest
                        """
                    )
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding()
                } else {
                    VStack(spacing: 20) {
                        Text("You are currently signed in as:")
                        Text("ozma@catterwaul.com") // TODO: Add real user email
                            .font(.title)
                    }
                    .padding()
                }
                Button { } // TODO: Sign user out
            label: { SignOutButton() }
                Spacer()
            }
            Spacer()
        }
        .padding()
    }

    struct SignOutButton: View {
        var body: some View {
            HStack {
                Text("Sign Out")
                    .foregroundColor(Color.white)
            }
            .padding()
            .background(Color("blue-curious"))
            .cornerRadius(15)
        }
    }
}
