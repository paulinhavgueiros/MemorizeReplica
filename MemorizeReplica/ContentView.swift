//
//  ContentView.swift
//  MemorizeReplica
//
//  Created by Paula Vasconcelos Gueiros on 17/02/21.
//

import SwiftUI

struct ContentView: View {
    var viewModel: MemoryGameViewModel
    
    var body: some View {
        HStack {
            ForEach(viewModel.cards.shuffled()) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
            }
        }
        .foregroundColor(.orange)
        .padding()
        .font((viewModel.cards.count == 10) ? .title : .largeTitle)
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3.0)
                Text(card.content)
            } else {
                RoundedRectangle(cornerRadius: 10.0).fill()
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MemoryGameViewModel())
    }
}
