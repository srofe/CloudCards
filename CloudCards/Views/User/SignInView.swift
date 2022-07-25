//
// Created by Simon Rofe on 19/7/2022.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @ObservedObject var cardListViewModel: CardListView.Model

    var body: some View {
        ZStack {
            SignInBackgroundView()
            VStack(alignment: .center, spacing: 20) {
                Text("Sign In to Cloud Cards")
                    .font(.largeTitle)
                    .foregroundColor(Color("rw-dark"))
                UserInfoForm(email: $email, password: $password)
                VStack {
                    Button {
                        AuthenticationService.signIn(email: email, password: password) { _, error in
                            print("Error signing in: \(error.localizedDescription)")
                        }
                    } label: { SignInButton() }
                    Button {
                        AuthenticationService.addNewUser(email: email, password: password) { authResult, error in
                            if let error = error {
                                // TODO: handle error
                                print("Error creating new user: \(error.localizedDescription)")
                            } else {
                                if let userInfo = authResult?.additionalUserInfo, userInfo.isNewUser {
                                    cardListViewModel.addStarterCards()
                                }
                            }
                        }
                    } label: { SignUpButton() }
                        .disabled(email.isEmpty || password.count < 6)
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(cardListViewModel: CardListView.Model())
    }
}

// MARK: - User Info Form
struct UserInfoForm: View {
    @Binding var email: String
    @Binding var password: String

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Email")
                    .foregroundColor(Color("rw-dark"))
                TextField("Enter your email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
            }
            VStack(alignment: .leading, spacing: 10) {
                Text("Password")
                    .foregroundColor(Color("rw-dark"))
                TextField("Enter a password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.default)
            }
        }
    }
}

// MARK: - Button Views
struct SignUpButton: View {
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        HStack {
            Spacer()
            Text("Sign Up")
                .foregroundColor(isEnabled ? .white : Color("grey-iron"))
            Spacer()
        }
        .padding()
        .background(
            Color("grey-lynch")
                .opacity(isEnabled ? 1 : 0.5)
        )
        .cornerRadius(15)
    }
}

struct SignInButton: View {
    @Environment(\.isEnabled) var isEnabled

    var body: some View {
        HStack {
            Spacer()
            Text("Sign In")
                .foregroundColor(isEnabled ? .white : Color("grey-iron"))
            Spacer()
        }
        .padding()
        .background(
            Color("blue-curious")
                .opacity(isEnabled ? 1 : 0.5)
        )
        .cornerRadius(15)
    }
}

// MARK: - Background View
struct SignInBackgroundView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color("grey-iron")
            Image(systemName: "cloud.fill")
                .resizable()
                .scaledToFit()
                .scaleEffect(1.2)
                .offset(y: 30)
                .foregroundColor(Color("blue-azure").opacity(0.1))
        }
        .ignoresSafeArea()
    }
}
