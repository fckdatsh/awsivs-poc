//
//  MessageList.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import SwiftUI

struct MessageList: View {
    
    //MARK: - Properties
    
    let messages: [MessageViewModel]
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(messages) { message in
                    MessageRow(message: message)
                }
            }
            .flippedUpsideDown()
            .padding(.vertical)
        }
        .flippedUpsideDown()
    }
}

private struct FlippedUpsideDown: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(.radians(Double.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

private extension View {
    func flippedUpsideDown() -> some View {
        modifier(FlippedUpsideDown())
    }
}

struct MessageList_Previews: PreviewProvider {
    static var previews: some View {
        MessageList(messages: [
            MessageViewModel(id: UUID().uuidString, content: "Ich hasse kinder"),
            MessageViewModel(id: UUID().uuidString, content: "Ich auch 🎉"),
        ])
    }
}
