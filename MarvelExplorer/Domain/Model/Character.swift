import Foundation

struct Character {
    let id: Int
    let name: String
    let resultDescription: String
    let modified: Date
    let resourceURI: URL?
    let urls: [URLResource]
    let thumbnailURL: URL?
    let comics: ResourceList<Event>?
    let stories: ResourceList<Event>?
    let events: ResourceList<Event>?
    let series: ResourceList<Event>?
}

extension Character: GridViewItemModel {
    var url: URL? {
        thumbnailURL
    }
}

#if DEBUG
extension Character {
    static let mock = Character(id: 0,
                                name: "Characeter",
                                resultDescription: "",
                                modified: Date(),
                                resourceURI: nil,
                                urls: [],
                                thumbnailURL: URL(string: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark.png"),
                                comics: nil,
                                stories: nil,
                                events: nil,
                                series: nil)
}
#endif
