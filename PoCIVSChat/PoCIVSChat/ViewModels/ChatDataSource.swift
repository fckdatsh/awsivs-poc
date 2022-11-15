//
//  ChatDataSource.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import Foundation
import AmazonIVSChatMessaging

struct MessageViewModel: Identifiable {
    let id: String
    let content: String
}

class ChatDataSource: ChatRoomDelegate {
    
    //MARK: - Properties
    @Published var messages: [MessageViewModel] = []
    
    func room(_ room: ChatRoom, didReceive message: ChatMessage) {
        messages.append(.init(id: message.id, content: message.content))
    }
    
//    func room(_ room: ChatRoom, didReceive event: ChatEvent) {
//        <#code#>
//    }
//    
//    func room(_ room: ChatRoom, didDelete message: DeletedMessage) {
//        <#code#>
//    }
//    
//    func room(_ room: ChatRoom, didDisconnect user: DisconnectedUser) {
//        <#code#>
//    }
}
