//
//  CardListView.swift
//  CloudCards
//
//  Created by Simon Rofe on 20/7/2022.
//

import SwiftUI

struct CardListView: View {
    @ObservedObject var model = Model()
    @State var showForm = false
    @State var showUserView = false
    @State var showSignInView = false

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView(.vertical) {
                    VStack {
                        ForEach(model.cardViewModels) { cardViewModel in
                            CardView(model: cardViewModel)
                                .padding(.vertical)
                        }
                    }
                    .frame(width: geometry.size.width)
                }
            }
            .sheet(isPresented: $showForm) {
                NewCardForm(cardListViewModel: model)
            }
            .navigationTitle("Cloud Cards")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button { showUserView = true }
                label: {
                    Image(systemName: "person.fill")
                        .font(.title)
                },
                trailing: Button { showForm.toggle() }
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
