import Foundation
import Combine

final class CharactersManager: ObservableObject {
    @Published private(set) var characters: [Character] = []
    @Published var isError: Bool = false
    @Published var filter: String = ""

    private(set) var offset: Int = 0
    private(set) var limit: Int
    private(set) var total: Int = 0
    private(set) var count: Int = 0
    private(set) var isFull = false

    private var networkController: MarvelNetworkController?
    private var cancellable: AnyCancellable?
    private var filterCancellable: AnyCancellable?
    private var resolver: Resolvable

    init(limit: Int, resolver: Resolvable) {
        self.limit = limit
        self.networkController = resolver()
        self.resolver = resolver
        filterCancellable = $filter.sink { filter in
            self.characters.removeAll()
            self.offset = 0
            self.total = 0
            self.count = 0
            self.isFull = false
            self.load(filter)
        }
    }

    func load(_ filter: String? = nil) {
        if isFull { return }

        isError = false

        cancellable = getPagedCharacters(limit: limit, offset: characters.count, filter: filter ?? self.filter)?
            .sink { completed in
                switch completed {
                case .finished: break
                case .failure:
                    self.isError = true
                }
            } receiveValue: { (pagedResponse) in
                self.characters.append(contentsOf: pagedResponse.results?.map({ $0.toDomain(resolver: self.resolver) }) ?? [])
                self.total = pagedResponse.total ?? 0
                self.count = pagedResponse.count ?? 0
                self.offset = pagedResponse.offset ?? 0
                self.isFull = pagedResponse.count == pagedResponse.total
            }
    }

    private func getPagedCharacters(limit: Int, offset: Int, filter: String?) -> AnyPublisher<PagedResponse<CharacterResponse>, Error>? {
        networkController?.characters(limit: limit, offset: offset, nameStartsWith: filter)
            .subscribe(on: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

#if DEBUG
extension CharactersManager {
    static var mock: CharactersManager = {

        struct Mock: MarvelNetworkController {
            func characters(limit: Int, offset: Int, nameStartsWith: String?) -> AnyPublisher<PagedResponse<CharacterResponse>, Error> {
                var characters: [CharacterResponse] = []
                (0..<30).forEach { _ in
                    characters.append(CharacterResponse.mock)
                }
                let pagedRespose = PagedResponse(offset: 0, limit: 0, total: 0, count: 0, results: characters)
                return Result<PagedResponse<CharacterResponse>, Error>.Publisher(.success(pagedRespose)).eraseToAnyPublisher()
            }
        }

        let locator = Locator()
        locator.register(Mock())

        return CharactersManager(limit: 0, resolver: locator)
    }()
}
#endif
