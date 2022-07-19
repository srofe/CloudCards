//
//  CardListView.ViewModel.swift
//  CloudCards
//
//  Created by Simon Rofe on 19/7/2022.
//

import Foundation
import Combine

extension CardListView {
    final class Model: ObservableObject {
        @Published var cardViewModels: [CardView.Model] = []
    }
}
