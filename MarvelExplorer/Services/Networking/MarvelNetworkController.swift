import Foundation
import Combine

protocol MarvelNetworkController {
    var networkDispatcher: TargetRequestable { get }
    func characters(limit: Int, offset: Int, nameStartsWith: String?) -> AnyPublisher<PagedContent<Character>, Error>
}

final class DefaultNetworkController: MarvelNetworkController {

    var networkDispatcher: TargetRequestable

    init(networkDispatcher: TargetRequestable) {
        self.networkDispatcher = networkDispatcher
    }

    func characters(limit: Int, offset: Int, nameStartsWith: String?) -> AnyPublisher<PagedContent<Character>, Error> {
        let publisher: AnyPublisher<DataWrapperResponse<PagedResponse<CharacterResponse>>, Error> =
            networkDispatcher.request(MarvelAPI.characters(limit: limit, offset: offset, nameStartsWith: nameStartsWith))
        return publisher.compactMap(\.data?.toDomain).eraseToAnyPublisher()
    }
}
