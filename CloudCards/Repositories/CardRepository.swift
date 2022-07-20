//
//  CardRepository.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class CardRepository: ObservableObject {
    private let store = Firestore.firestore()
    private let path = "cards"
    @Published var cards: [Card] = []

    init() {
        get()
    }

    func get() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetting cards: \(error.localizedDescription)")
                    return
                }
                self.cards = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Card.self)
                } ?? []
            }
    }
}
