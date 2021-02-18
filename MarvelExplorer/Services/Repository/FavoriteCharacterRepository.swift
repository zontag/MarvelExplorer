import Foundation

protocol FavoriteCharacterRepository {
    func save(_ id: Int)
    func remove(_ id: Int)
    func contains(_ id: Int) -> Bool
}

final class UserDefaultsFavoriteCharacterRepo: FavoriteCharacterRepository {

    private let favoriteKey = "FavoriteCharacterUserDefaultsKey"

    private var cache: Set<Int>  = []

    init() {
        loadAll()
    }

    func save(_ id: Int) {
        cache.insert(id)
        UserDefaults.standard.set(Array(cache), forKey: favoriteKey)
    }

    func remove(_ id: Int) {
        cache.remove(id)
        UserDefaults.standard.set(Array(cache), forKey: favoriteKey)
    }

    func contains(_ id: Int) -> Bool {
        cache.contains(id)
    }

    private func loadAll() {
        let array = UserDefaults.standard.array(forKey: favoriteKey) as? [Int] ?? []
        let favoriteSet = Set<Int>(array)
        cache = favoriteSet
    }
}
