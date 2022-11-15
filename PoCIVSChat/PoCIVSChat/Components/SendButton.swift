//
//  SendButton.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import SwiftUI
import AmazonIVSChatMessaging

struct SendButton: View {
    
    //MARK: - Properties
    let state: ChatRoom.State
    
    var onSend: () -> Void
    
    var body: some View {
        Button(action: onSend) {
            switch state {
            case .connecting:
                ProgressView()
                    .padding()
                    .background(Color(.tertiarySystemFill))
            case .connected:
                Image(systemName: "paperplane.fill")
                    .padding()
                    .background(Color(.tintColor))
                    .foregroundColor(.white)
            case .disconnected:
                Image(systemName: "antenna.radiowaves.left.and.right.slash")
                    .padding()
                    .background(Color(.systemRed).opacity(0.2))
                    .foregroundColor(Color(.tertiaryLabel))
            }
        }
        .clipShape(Circle())
        .padding()

    }
}

struct SendButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(ChatRoom.State.allCases, id: \.rawValue) { state in
                SendButton(state: state, onSend: {})
                    .previewLayout(.sizeThatFits)
            }
        }
    }
}
