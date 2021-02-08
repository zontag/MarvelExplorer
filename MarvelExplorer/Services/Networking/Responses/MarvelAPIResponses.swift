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
    let comics: ResourceListResponse<EventResponse>?
    let stories: ResourceListResponse<EventResponse>?
    let events: ResourceListResponse<EventResponse>?
    let series: ResourceListResponse<EventResponse>?
}

// MARK: - ResourceListResponse
struct ResourceListResponse<Element>: Decodable where Element: Decodable {
    let available: Int?
    let returned: Int?
    let collectionURI: String?
    let items: [Element]?
}

// MARK: - EventResponse
struct EventResponse: Codable {
    let resourceURI: String?
    let name: String?
    let type: String?
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
