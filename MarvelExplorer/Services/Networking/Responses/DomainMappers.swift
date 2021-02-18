import Foundation

protocol DomainMappable {
    associatedtype DomainType
    func toDomain(resolver: Resolvable) -> DomainType
}

extension URLResourceResponse: DomainMappable {
    func toDomain(resolver: Resolvable) -> URLResource {
        .init(type: type,
              url: URL(string: url ?? ""))
    }
}

extension CharacterResponse: DomainMappable {
    func toDomain(resolver: Resolvable) -> Character {
        .init(id: id ?? 0,
              name: name,
              resultDescription: description,
              modified: ISO8601DateFormatter().date(from: modified ?? ""),
              resourceURI: URL(string: resourceURI ?? ""),
              urls: urls?.map { $0.toDomain(resolver: resolver) } ?? [],
              thumbnailURL: URL(string: (thumbnail?.path ?? "") + "." + (thumbnail?.extension ?? "")),
              resolver: resolver)
    }
}
