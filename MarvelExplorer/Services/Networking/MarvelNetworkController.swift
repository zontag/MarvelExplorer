import Foundation
import Combine

protocol MarvelNetworkController {
    var networkDispatcher: TargetRequestable { get }
    func characters(limit: Int, offset: Int) -> AnyPublisher<PagedContent<Character>, Error>
}

final class DefaultNetworkController: MarvelNetworkController {

    var networkDispatcher: TargetRequestable

    init(networkDispatcher: TargetRequestable) {
        self.networkDispatcher = networkDispatcher
    }

    func characters(limit: Int, offset: Int) -> AnyPublisher<PagedContent<Character>, Error> {
        let publisher: AnyPublisher<DataWrapperResponse<PagedResponse<CharacterResponse>>, Error> =
            networkDispatcher.request(MarvelAPI.characters(limit: limit, offset: offset))
        return publisher.compactMap(\.data?.toDomain).eraseToAnyPublisher()
    }
}
