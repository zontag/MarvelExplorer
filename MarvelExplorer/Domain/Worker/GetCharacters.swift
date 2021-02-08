import Foundation
import Combine

protocol GetCharacters {
    func callAsFunction(limit: Int, offset: Int) -> AnyPublisher<PagedContent<Character>, Error>
}

struct GetCharactersWorker: GetCharacters {

    let networkController: MarvelNetworkController

    func callAsFunction(limit: Int, offset: Int) -> AnyPublisher<PagedContent<Character>, Error> {
        networkController.characters(limit: limit, offset: offset)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
