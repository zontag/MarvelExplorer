import Foundation

enum MarvelAPI {
    case characters(limit: Int, offset: Int, nameStartsWith: String?)
}

extension MarvelAPI: Target {

    static let publicKey = "c3606d96a1e199fb347665361d040c9b"
    static let privateKey = "fab7f1177ea196548c4e9a0822d8260d41f2dd35"

    var baseURL: String { "gateway.marvel.com" }

    var path: String {
        switch self {
        case .characters: return "/v1/public/characters"
        }
    }

    var method: NetworkingMethod {
        switch self {
        case .characters: return .get
        }
    }

    var queryParams: [String: String?] {
        switch self {
        case .characters(let limit, let offset, let nameStartsWith):
            let timeStamp = self.timeStamp
            return [
                "ts": timeStamp,
                "apikey": MarvelAPI.publicKey,
                "hash": timeStamp.appending(MarvelAPI.privateKey).appending(MarvelAPI.publicKey).toMD5Hash(),
                "limit": String(limit),
                "offset": String(offset),
                "nameStartsWith": nameStartsWith
            ]
        }
    }

    private var timeStamp: String {
        String(format: "%.0f", Date().timeIntervalSince1970)
    }
}
