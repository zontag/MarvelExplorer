import Foundation

protocol DomainMappable {
    associatedtype DomainType
    var toDomain: DomainType { get }
}

extension URLResourceResponse: DomainMappable {
    var toDomain: URLResource {
        .init(type: type ?? "",
              url: URL(string: url ?? ""))
    }
}

extension EventResponse: DomainMappable {
    var toDomain: Event {
        .init(resourceURI: URL(string: resourceURI ?? ""),
              name: name ?? "",
              type: type ?? "")
    }
}

extension ResourceListResponse: DomainMappable where Element: DomainMappable {
    var toDomain: ResourceList<Element.DomainType> {
        .init(available: available ?? 0,
              returned: returned ?? 0,
              collectionURI: URL(string: collectionURI ?? ""),
              items: items?.map(\.toDomain) ?? [])
    }
}

extension CharacterResponse: DomainMappable {
    var toDomain: Character {
        .init(id: id ?? 0,
              name: name ?? "",
              resultDescription: description ?? "",
              modified: ISO8601DateFormatter().date(from: modified ?? "") ?? Date(),
              resourceURI: URL(string: resourceURI ?? ""),
              urls: urls?.map(\.toDomain) ?? [],
              thumbnailURL: URL(string: (thumbnail?.path ?? "") + "." + (thumbnail?.extension ?? "")),
              comics: comics?.toDomain,
              stories: stories?.toDomain,
              events: events?.toDomain,
              series: series?.toDomain)
    }
}

extension PagedResponse where Element: DomainMappable {
    var toDomain: PagedContent<Element.DomainType> {
        PagedContent(offset: offset ?? 0,
                     limit: limit ?? 0,
                     total: total ?? 0,
                     count: count ?? 0,
                     results: results?.map(\.toDomain) ?? [])
    }
}
