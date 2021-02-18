import Foundation

protocol Resolvable {
    func callAsFunction<T>() -> T?
}

final class Locator: Resolvable {

    private var services: [ObjectIdentifier: Any] = [:]

    func callAsFunction<T>() -> T? {
        return services[key(for: T.self)] as? T
    }

    func register<T>(_ service: T) {
        services[key(for: T.self)] = service
    }

    private func key<T>(for type: T.Type) -> ObjectIdentifier {
        return ObjectIdentifier(T.self)
    }

}
