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
