//
//  AuthenticationService.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import Firebase

class AuthenticationService: ObservableObject {
    @Published var user: User?
    private var authenticationStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        addListeners()
    }

    static func signIn() {
        if Auth.auth().currentUser == nil {
            Auth.auth().signInAnonymously()
        }
    }

    private func addListeners() {
        if let handle = authenticationStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        authenticationStateHandle = Auth.auth()
            .addStateDidChangeListener { _, user in
                self.user = user
            }
    }
}
