import Foundation
import Combine

final class PagedContent<Element>: ObservableObject {
    @Published private(set) var results: [Element] = []
    @Published var isError: Bool = false
    @Published var filter: String = ""

    private(set) var offset: Int = 0
    private(set) var limit: Int
    private(set) var total: Int = 0
    private(set) var count: Int = 0
    private(set) var isFull = false

    var getPagedContentWorker: AnyGetPagedContentWorker<Element>?

    private var cancellable: AnyCancellable?
    private var filterCancellable: AnyCancellable?

    init(limit: Int, worker: AnyGetPagedContentWorker<Element>) {
        self.limit = limit
        self.getPagedContentWorker = worker
        filterCancellable = $filter.sink { filter in
            self.results.removeAll()
            self.offset = 0
            self.total = 0
            self.count = 0
            self.isFull = false
            self.load(filter)
        }
    }

    init(offset: Int, limit: Int, total: Int, count: Int, results: [Element]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }

    func load(_ filter: String? = nil) {
        if isFull {
            return
        }

        if getPagedContentWorker == nil {
            preconditionFailure()
        }

        isError = false

        cancellable = getPagedContentWorker?(limit: limit, offset: results.count, filter: filter ?? self.filter)
            .sink { completed in
                switch completed {
                case .finished: break
                case .failure:
                    self.isError = true
                }
            } receiveValue: { (pagedContent) in
                self.results.append(contentsOf: pagedContent.results)
                self.total = pagedContent.total
                self.count = pagedContent.count
                self.offset = pagedContent.offset
                self.isFull = pagedContent.count == pagedContent.total
            }
    }
}

#if DEBUG
extension PagedContent where Element == Character {
    static var mockCharacter: PagedContent<Character> = {
        var characters: [Character] = []
        for index in 0..<30 {
            characters.append(Character.mock)
        }
        return PagedContent(offset: 0, limit: 30, total: 100, count: 4, results: characters)
    }()
}
#endif
