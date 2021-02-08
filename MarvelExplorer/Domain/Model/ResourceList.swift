import Foundation

// MARK: - ResourceList
struct ResourceList<Element> {
    let available: Int
    let returned: Int
    let collectionURI: URL?
    let items: [Element]
}
