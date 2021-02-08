import Foundation
import Combine

class PagedContent<Element>: ObservableObject {
    @Published private(set) var results: [Element] = []
    @Published var isError: Bool = false

    private(set) var offset: Int = 0
    private(set) var limit: Int
    private(set) var total: Int = 0
    private(set) var count: Int = 0
    private(set) var isFull = false

    var getPagedContent: ((_ limit: Int, _ offset: Int) -> AnyPublisher<PagedContent<Element>, Error>)?

    private var cancellable: AnyCancellable?

    init(limit: Int) {
        self.limit = limit
    }

    init(offset: Int, limit: Int, total: Int, count: Int, results: [Element]) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }

    func load() {
        if isFull {
            return
        }

        if getPagedContent == nil {
            preconditionFailure()
        }

        isError = false

        cancellable = getPagedContent?(limit, results.count)
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
