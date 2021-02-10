import Foundation
import Combine

struct GetCharactersWorker: GetPagedContentWorker {

    let networkController: MarvelNetworkController

    func callAsFunction(limit: Int, offset: Int, filter: String?) -> AnyPublisher<PagedContent<Character>, Error> {
        networkController.characters(limit: limit, offset: offset, nameStartsWith: filter)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
