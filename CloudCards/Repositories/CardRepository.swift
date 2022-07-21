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
    var userID = ""
    private let authenticationService = AuthenticationService()
    private var cancellables: Set<AnyCancellable> = []

    init() {
        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userID, on: self)
            .store(in: &cancellables)
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.get()
            }
            .store(in: &cancellables)
    }

    func get() {
        store.collection(path)
            .whereField("userID", isEqualTo: userID)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting cards: \(error.localizedDescription)")
                    return
                }
                self.cards = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Card.self)
                } ?? []
            }
    }

    func add(_ card: Card) {
        do {
            var newCard = card
            newCard.userID = userID
            _ = try store.collection(path).addDocument(from: newCard)
        } catch {
            fatalError("Unable to add card: \(error.localizedDescription)")
        }
    }

    func update(_ card: Card) {
        guard let cardID = card.id else { return }
        do {
            try store.collection(path).document(cardID).setData(from: card)
        } catch {
            fatalError("Unable to update card: \(error.localizedDescription)")
        }
    }

    func remove(_ card: Card) {
        guard let cardID = card.id else { return }
        store.collection(path).document(cardID).delete { error in
            if let error = error {
                print("Unable to remove card: \(error.localizedDescription)")
            }
        }
    }
}
