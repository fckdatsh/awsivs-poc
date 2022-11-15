//
//  TokenRequest.swift
//  PoCIVSChat
//
//  Created by Rob on 3/11/22.
//

import Foundation

struct TokenRequest: Codable {
    //MARK: - Properties
    
    enum UserCapability: String, Codable {
        case deleteMessage = "DELETE_MESSAGE"
        case disconnectUser = "DISCONNECT_USER"
        case sendMessage = "SEND_MESSAGE"
    }
    
    let roomIdentifier: String
    let userId: String
    let sessionDurationInMinutes: Int
    let attributes: [String: String]
    let capabilities: [UserCapability]
    
    var awsRegion: String {
        roomIdentifier.components(separatedBy: ":")[3]
    }
    
    func fetchResponse() async throws -> Data {
        let url = URL(string: "http://127.0.0.1:7000/invoke")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try JSONEncoder().encode(self)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    static var ´default´: TokenRequest = .init(
        roomIdentifier: "",
        userId: UUID().uuidString,
        sessionDurationInMinutes: 180,
        attributes: [:],
        capabilities: [.sendMessage]
    )
}
