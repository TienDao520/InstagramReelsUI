//
//  CarouselView.swift
//  CarouselAndTabView
//
//  Created by Tien Dao on 2022-11-07.
//

import SwiftUI

private class StateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}

struct CarouselCard: Decodable, Hashable, Identifiable {
    let id: Int
    let text: String
    let image: String
}

private struct CarouselDotsView: View {
    @EnvironmentObject private var state: StateModel
    let cards: [CarouselCard]
    let size: CGFloat = 10
    
    var body: some View {
        HStack {
            ForEach(cards, id: \.self.id) { card in
                Circle()
                    .fill(card.id == state.activeCard ? Color.primary : Color.secondary)
                    .frame(width: size, height: size)
            }
        }
    }
}

private struct CarouselCardView: View {
    @EnvironmentObject private var state: StateModel
    let card: CarouselCard
    let width: CGFloat
    
    var body: some View {
        VStack {
            Text(card.text)
                .font(.largeTitle)
                .padding(.vertical)
            Spacer()
            Image(systemName: card.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            Spacer()
            
        }
        .opacity((card.id == state.activeCard || state.screenDrag != 0) ? 1.0 : 0.0)
        .frame(minWidth: width, maxHeight: .infinity, alignment: .center)
    }
}

private struct CarouselInnerView<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat
    let spacing: CGFloat
    let widthOfHiddenCards: CGFloat
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDragging = false
    
    @EnvironmentObject private var state: StateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2)
        
    }
    
    func calculateOffset() -> CGFloat {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(state.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(state.activeCard) + 1)
        
        var offset = Float(activeOffset)
        
        if (offset != Float(nextOffset)) {
            offset = Float(activeOffset) + state.screenDrag
        }
        
        return CGFloat(offset);
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: calculateOffset())
//        .animation(.spring())
        .gesture(DragGesture().updating($isDragging) { currentState, gestureState, transaction in
            self.state.screenDrag = Float(currentState.translation.width)
        }.onEnded { value in
            self.state.screenDrag = 0
            
            if value.translation.width < -50 {
                if self.state.activeCard < Int(numberOfItems) - 1 {
                    self.state.activeCard += 1
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                } else {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
            } else if value.translation.width > 50 {
                if self.state.activeCard > 0 {
                    self.state.activeCard -= 1
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                } else {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
            }
        })
    }
}

struct CarouselView: View {
    private let state = StateModel()
    let cards: [CarouselCard]
    
    var body: some View {
        let spacing: CGFloat = 16
        let widthOfHiddenCards: CGFloat = 16
        let cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards * 2) - (spacing * 2)
        
//        return VStack {
        VStack {
            CarouselInnerView(
                numberOfItems: CGFloat(cards.count),
                spacing: spacing,
                widthOfHiddenCards: widthOfHiddenCards
            ) {
                ForEach(cards, id: \.self.id) { card in
                    CarouselCardView(card: card, width: cardWidth)
//                    Color.red
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: .infinity, alignment: .center)
            CarouselDotsView(cards: cards)
//            Color.red
        }
        .environmentObject(state)
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(cards: [
            CarouselCard(id: 0, text: "This is some pretty long text.", image: "square.dashed"),
            CarouselCard(id: 1, text: "This is also some pretty long text.", image: "square"),
            CarouselCard(id: 2, text: "This one has a circle.", image: "circle")
        ])
    }
}

