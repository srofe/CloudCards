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
        @Published var card: Card
        private var cancellables: Set<AnyCancellable> = []
        var id = ""

        init(card: Card) {
            self.card = card
            $card
                .compactMap { $0.id }
                .assign(to: \.id, on: self)
                .store(in: &cancellables)
        }
    }
}
