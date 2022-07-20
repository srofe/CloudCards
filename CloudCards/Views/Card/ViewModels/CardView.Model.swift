//
//  CardView.Model.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import Foundation
import Combine

extension CardView {
    final class Model: ObservableObject, Identifiable {
        private let cardRepository: CardRepository
        @Published var card: Card
        private var cancellables: Set<AnyCancellable> = []
        var id = ""

        func update(_ card: Card) {
            cardRepository.update(card)
        }

        func remove() {
            cardRepository.remove(card)
        }

        init(card: Card, cardRepository: CardRepository) {
            self.cardRepository = cardRepository
            self.card = card
            $card
                .compactMap { $0.id }
                .assign(to: \.id, on: self)
                .store(in: &cancellables)
        }
    }
}
