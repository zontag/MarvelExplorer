import Foundation

// MARK: - DataWrapperResponse
struct DataWrapperResponse<Data>: Decodable where Data: Decodable {
    let code: Int?
    let status: String?
    let copyright: String?
    let attributionText: String?
    let attributionHTML: String?
    let data: Data?
    let etag: String?
}

// MARK: - PagedResponse
struct PagedResponse<Element>: Decodable where Element: Decodable {
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Element]?
}

// MARK: - CharacterResponse
struct CharacterResponse: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let modified: String? // Date
    let resourceURI: String?
    let urls: [URLResourceResponse]?
    let thumbnail: ThumbnailResponse?
}

// MARK: - ThumbnailResponse
struct ThumbnailResponse: Decodable {
    let path: String?
    let `extension`: String?
}

// MARK: - URLResponse
struct URLResourceResponse: Decodable {
    let type: String?
    let url: String?
}
