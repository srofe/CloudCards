//
//  CardListView.ViewModel.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import Foundation
import Combine
import Firebase

extension CardListView {
    final class Model: ObservableObject {
        @Published var cardViewModels: [CardView.Model] = []
        @Published var cardRepository: CardRepository
        let authenticationService = AuthenticationService()
        @Published var user: User?
        private var cancellables: Set<AnyCancellable> = []

        init() {
            cardRepository = CardRepository(authenticationService: authenticationService)
            authenticationService.$user
                .assign(to: \.user, on: self)
                .store(in: &cancellables)
            cardRepository.$cards.map { cards in
                cards.map { card in
                    CardView.Model(card: card, repository: self.cardRepository)
                }
            }
            .assign(to: &$cardViewModels)
        }

        func add(_ card: Card) {
            cardRepository.add(card)
        }
    }
}
