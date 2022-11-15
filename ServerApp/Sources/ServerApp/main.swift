import AWSIvschat
import AWSLambdaRuntime
import Foundation

typealias Request = CreateChatTokenInput
typealias Response = CreateChatTokenOutputResponse

setenv("LOCAL_LAMBDA_SERVER_ENABLED", "true", 1)
Lambda.run { (context, input: Request, callback: @escaping (Result<Response, Error>) -> Void) in
    Task {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            let config = try await IvschatClient.IvschatClientConfiguration()
            config.decoder = decoder

            let client = IvschatClient(config: config)
            let token = try await client.createChatToken(input: input)
            callback(.success(token))
        } catch {
            callback(.failure(error))
        }
    }
}

extension CreateChatTokenInput: Decodable {
    private enum Keys: String, CodingKey {
        case attributes
        case capabilities
        case roomIdentifier
        case sessionDurationInMinutes
        case userId
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        try self.init(
            attributes: container.decodeIfPresent([String : String].self, forKey: .attributes),
            capabilities: container.decodeIfPresent([IvschatClientTypes.ChatTokenCapability].self, forKey: .capabilities),
            roomIdentifier: container.decodeIfPresent(String.self, forKey: .roomIdentifier),
            sessionDurationInMinutes: container.decode(Int.self, forKey: .sessionDurationInMinutes),
            userId: container.decodeIfPresent(String.self, forKey: .userId)
        )
    }
}

extension CreateChatTokenOutputResponse: Encodable {
    private enum Keys: String, CodingKey {
        case token
        case tokenExpirationTime
        case sessionExpirationTime
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(token, forKey: .token)
        try container.encodeIfPresent(tokenExpirationTime, forKey: .tokenExpirationTime)
        try container.encodeIfPresent(sessionExpirationTime, forKey: .sessionExpirationTime)
    }
}
