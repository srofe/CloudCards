//
// Created by Simon Rofe on 19/7/2022.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button {
                // TODO: Sign in anonymously
                presentationMode.wrappedValue.dismiss()
            } label: { GuestSignInButton() }
            Divider().padding(.vertical)
            UserInfoForm(email: $email, password: $password)
            Button {
                // TODO: Sign in with email & password
                presentationMode.wrappedValue.dismiss()
            } label: { SignInButton() }
                .disabled(true)
            Button {
                // TODO: Add a new user
                presentationMode.wrappedValue.dismiss()
            } label: { SignUpButton() }
                .disabled(true)
            Spacer()
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
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
struct GuestSignInButton: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "cloud.fill")
                .font(.title)
                .foregroundColor(Color("grey-iron"))
            Text("Try Cloud Cards as a Guest")
                .foregroundColor(Color.white)
            Spacer()
        }
        .padding()
        .background(Color("blue-curious"))
        .cornerRadius(15)
    }
}

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
