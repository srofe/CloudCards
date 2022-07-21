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

    static func signIn(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
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
