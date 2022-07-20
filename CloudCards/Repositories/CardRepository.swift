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

    func add(_ card: Card) {
        do {
            _ = try store.collection(path).addDocument(from: card)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription)")
        }
    }

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
