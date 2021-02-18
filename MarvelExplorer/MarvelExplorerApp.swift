import SwiftUI

@main
struct MarvelExplorerApp: App {

    var resolver: Resolvable = {
        let locator = Locator()
        locator.register(DefaultNetworkController(networkDispatcher: URLSession.shared) as MarvelNetworkController)
        locator.register(UserDefaultsFavoriteCharacterRepo() as FavoriteCharacterRepository)
        return locator
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharactersView()
                .environmentObject(CharactersManager(limit: 10, resolver: resolver))
                .navigationBarTitle("Characteres")
            }
        }
    }
}
