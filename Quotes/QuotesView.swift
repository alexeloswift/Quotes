//
//  QuotesView.swift
//  Quotes
//
//  Created by Alexis Diaz on 10/31/22.
//

import SwiftUI

struct QuotesView: View {

    //    MARK: - Wrapped Properties

    @StateObject private var viewmodel = QuotesViewmodel()
    @State var angle = 0.0

    //    MARK: - Body View

    var body: some View {
        NavigationView {
            ZStack {
                let timer = Timer.publish(every: viewmodel.timeLeft, on: .main, in: .common).autoconnect()
                starWarsImage
                VStack {
                    quote
                    author
                }
                .padding()
                .rotationEffect(.degrees(angle))
                .animation(.easeOut(duration: 0.7) , value: angle)
                .onReceive(timer) { _ in
                    viewmodel.updateQuote()
                    angle += 360
                }
                .navigationTitle("Star Wars Quotes")
            }
        }
    }

    // MARK: - Supporting Body Views

    /// Background Image
    private var starWarsImage: some View {
        Image("r2d2")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()
    }

    /// Quote Data
    private var quote: some View {
        Text("\"\(viewmodel.currentQuote.quote)\"")
            .font(.headline)
            .multilineTextAlignment(.center)
            .fontWeight(.bold)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14.0)
                    .foregroundStyle(.ultraThinMaterial)
                    .frame(width: 350.0, height: 500.0))
    }

    private var author: some View {
        Text(viewmodel.currentQuote.author)
            .font(.title3).bold()
            .foregroundStyle(.opacity(0.8))
    }
}

// MARK: - Canvas

struct QuotesView_Previews: PreviewProvider {
    static var previews: some View {
        QuotesView()
    }
}
