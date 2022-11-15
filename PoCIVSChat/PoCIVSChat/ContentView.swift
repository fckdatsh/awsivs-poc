//
//  ContentView.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import SwiftUI
import AmazonIVSChatMessaging

struct ContentView: View {
    
    //MARK: - Properties
    
    private let room: ChatRoom
    private let viewModel = ChatDataSource()
    
    @State var state: ChatRoom.State = .connecting
    @State var messages: [MessageViewModel] = []
    
    init(request: TokenRequest) {
        self.room = ChatRoom(awsRegion: request.awsRegion, asyncTokenProvider: {
            let data = try await request.fetchResponse()
            return try JSONDecoder().decode(ChatToken.self, from: data)
        })
        
        self.room.delegate = viewModel
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            MessageList(messages: messages)
            Divider()
            MessageBar(state: state) { message in
                try await room.perform(request: SendMessageRequest(content: message))
            }
        }
        .onReceive(room.$state
            .combineLatest(viewModel.$messages)
            .receive(on: RunLoop.main), perform: { state, messages in
            self.state = state
            self.messages = messages
        })
        .task {
            do {
                try await room.connect()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(request: TokenRequest.´default´)
    }
}
