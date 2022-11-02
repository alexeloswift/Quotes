//
//  QuotesViewmodel.swift
//  Quotes
//
//  Created by Alexis Diaz on 10/31/22.
//

import Foundation

class QuotesViewmodel: ObservableObject {

    //    MARK: - Wrapped Properties

    @Published var currentQuote = QuoteModel(quote: "Help me, Obi-Wan Kenobi. You’re my only hope.", author: "Leia Organa", slideTransitionDelay: 3000)

    //    MARK: - Unwrapped Properties

    var currentSlide: Int = 0
    var timeLeft: Double = 0

    //    MARK: - Quote Data Array

    let quotesData = [
        QuoteModel(quote: "Help me, Obi-Wan Kenobi. You’re my only hope.", author: "Leia Organa", slideTransitionDelay: 3000),
        QuoteModel(quote:  "The Force will be with you. Always.", author:  "Obi-Wan Kenobi", slideTransitionDelay: 2000),
        QuoteModel(quote: "It’s the ship that made the Kessel run in less than twelve parsecs. I’ve outrun Imperial starships. Not the local bulk cruisers, mind you. I’m talking about the big Corellian ships, now. She’s fast enough for you, old man.", author: "Han Solo", slideTransitionDelay: 6000),
        QuoteModel(quote: "Do. Or do not. There is no try.", author: "Yoda", slideTransitionDelay: 2000)
    ]

    //    MARK: - Methods

    /// This method decides what to do based on what the current value of currentSlide is
    func updateQuote() {
        if currentSlide < 3 && currentSlide > -1 {
            print("               ")
            print("current slide index: \(currentSlide)")
            self.currentQuote = quotesData[currentSlide]
            currentSlide += 1
            timeLeft = Double(currentQuote.slideTransitionDelay) / 1000
            print(currentQuote)
        } else if currentSlide == 3 {
            self.currentQuote = quotesData[currentSlide]
            print("               ")
            print("current slide index: \(currentSlide)")
            timeLeft = Double(currentQuote.slideTransitionDelay) / 1000
            print(currentQuote)
            currentSlide = 0
        }
    }
}
