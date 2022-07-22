//
//  CardListView.swift
//  CloudCards
//
//  Created by Simon Rofe on 20/7/2022.
//

import Firebase
import SwiftUI

struct CardListView: View {
    @ObservedObject var model = Model()
    @State var showForm = false
    // TODO: add showSignIn

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        ForEach(model.cardViewModels) { cardViewModel in
                            CardView(model: cardViewModel)
                                .padding([.vertical])
                        }
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .sheet(isPresented: $showForm) {
                NewCardForm(cardListViewModel: model)
            }
            // TODO: show SignInView
            .navigationTitle("Cloud Cards")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button { showForm.toggle() }
                        label: {
                                Image(systemName: "plus")
                                    .font(.title)
                        }
            )
        }
    }
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView()
    }
}
