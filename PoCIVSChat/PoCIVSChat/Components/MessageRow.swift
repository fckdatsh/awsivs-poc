//
//  MessageRow.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import SwiftUI

struct MessageRow: View {
    
    //MARK: - Properties
    
    let message: MessageViewModel
    
    var body: some View {
        HStack {
            Text(message.content)
                .padding()
                .background(Color(.tertiarySystemFill))
                .cornerRadius(8)
            Spacer()
                .padding(.trailing)
        }
        .padding(.horizontal)
    }
}

struct MessageRow_Previews: PreviewProvider {
    static var previews: some View {
        MessageRow(
            message: MessageViewModel(
                id: UUID().uuidString,
                content: "This is a message"
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
