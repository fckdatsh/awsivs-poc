//
//  MessageBar.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import SwiftUI
import AmazonIVSChatMessaging

struct MessageBar: View {
    
    //MARK: - Properties
    
    let state: ChatRoom.State
    let sendMessage: (String) async throws -> Void

    @State var draft: String = ""
    @State var isSending: Bool = false

    
    var body: some View {
        HStack(spacing: .zero) {
            TextField("Send a message", text: $draft)
                .padding([.vertical, .leading])
                .background(Capsule().fill(Color(.tertiarySystemFill)))

            SendButton(state: state) { [message = draft] in
                draft = ""
                isSending.toggle()

                Task {
                    try await sendMessage(message)
                    isSending.toggle()
                }
            }
            .disabled(isSending)
        }
        .padding(.leading)
    }
}

struct MessageBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ChatRoom.State.allCases, id: \.rawValue) { state in
                MessageBar(state: state) { message in
                    print(message)
                }.previewLayout(.sizeThatFits)
            }
        }
    }
}
