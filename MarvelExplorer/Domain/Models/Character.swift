import Foundation
import Combine

final class Character: ObservableObject {

    @Published var id: Int
    @Published var name: String?
    @Published var resultDescription: String?
    @Published var modified: Date?
    @Published var resourceURI: URL?
    @Published var urls: [URLResource] = []
    @Published var thumbnailURL: URL?

    private var favoriteRepo: FavoriteCharacterRepository?

    init(id: Int) {
        self.id = id
    }

    func favorite(_ isFavorite: Bool) {
        if isFavorite {
            favoriteRepo?.save(id)
        } else {
            favoriteRepo?.remove(id)
        }
    }
}

extension Character {
    convenience init(id: Int, name: String?, resultDescription: String?, modified: Date?,
                     resourceURI: URL?, urls: [URLResource], thumbnailURL: URL?, resolver: Resolvable) {
        self.init(id: id)
        self.name = name
        self.resultDescription = resultDescription
        self.modified = modified
        self.resourceURI = resourceURI
        self.urls = urls
        self.thumbnailURL = thumbnailURL
        self.favoriteRepo = resolver()
    }
}

extension Character: GridViewItemModel {
    var url: URL? {
        thumbnailURL
    }
}

extension Character: DetailViewModel {

    var isFavorite: Bool {
        favoriteRepo?.contains(id) ?? false
    }

    var description: String? {
        resultDescription
    }
}
