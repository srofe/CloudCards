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
    @State var showSignInView = false

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
            .fullScreenCover(isPresented: $showSignInView) {
                SignInView()
            }
            .onAppear {
                showSignInView = model.user == nil ? true : false
            }
            .onChange(of: model.user) { user in
                showSignInView = user == nil ? true : false
            }
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
