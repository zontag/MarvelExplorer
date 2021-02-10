import Foundation
import Combine

protocol GetPagedContentWorker {
    associatedtype Element
    func callAsFunction(limit: Int, offset: Int, filter: String?) -> AnyPublisher<PagedContent<Element>, Error>
}

struct AnyGetPagedContentWorker<Element>: GetPagedContentWorker {

    private let function: (_ limit: Int, _ offset: Int, _ filter: String?) -> AnyPublisher<PagedContent<Element>, Error>

    init<Worker: GetPagedContentWorker>(_ worker: Worker) where Worker.Element == Element {
        self.function = worker.callAsFunction
    }

    func callAsFunction(limit: Int, offset: Int, filter: String?) -> AnyPublisher<PagedContent<Element>, Error> {
        self.function(limit, offset, filter)
    }
}

extension GetPagedContentWorker {
    func eraseToAnyGetPagedContentWorker() -> AnyGetPagedContentWorker<Element> {
        AnyGetPagedContentWorker(self)
    }
}
