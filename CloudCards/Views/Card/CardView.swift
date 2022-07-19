//
//  CardView.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import SwiftUI

struct CardView: View {
    var model: Model
    @State var showContent = false
    @State var deleting = false
    @State var showAlert = false

    var body: some View {
        ZStack {
            backView.opacity(showContent ? 1 : 0)
            frontView.opacity(showContent ? 0 : 1)
        }
        .frame(width: 250, height: 200)
        .background(
            ZStack {
                showContent
                ? Color("grey-iron")
                : Color("blue-curious")
                Image(systemName: "cloud.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(Color("grey-iron").opacity(0.2))
                    .offset(y: 20)
            }
        )
        .cornerRadius(20)
        .shadow(
            color: Color("blue-azure").opacity(0.3),
            radius: 5, x: 10, y: 10)
        .scaleEffect(deleting ? 1.2 : 1)
        .rotation3DEffect(.degrees(showContent ? 180.0 : 0.0), axis: (x: 0, y: -1, z: 0))
        .animation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0))
        .onTapGesture {
            withAnimation {
                showContent.toggle()
            }
        }
        .onLongPressGesture {
            withAnimation {
                showAlert = true
                deleting = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Remove Card"),
                message: Text("Are you sure you want to remove this card?"),
                primaryButton: .destructive(Text("Remove")) {
                    withAnimation {
                        // TODO: Remove the card
                    }
                },
                secondaryButton: .cancel() {
                    withAnimation {
                        deleting = false
                    }
                }
            )
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
