import Foundation

enum MarvelAPI {
    case characters(limit: Int, offset: Int)
}

extension MarvelAPI: Target {

    static let publicKey = ""
    static let privateKey = ""

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

    var queryParams: [String: String] {
        switch self {
        case .characters(let limit, let offset):
            let timeStamp = self.timeStamp
            return [
                "ts": timeStamp,
                "apikey": MarvelAPI.publicKey,
                "hash": timeStamp.appending(MarvelAPI.privateKey).appending(MarvelAPI.publicKey).toMD5Hash(),
                "limit": String(limit),
                "offset": String(offset)
            ]
        }
    }

    private var timeStamp: String {
        String(format: "%.0f", Date().timeIntervalSince1970)
    }
}
