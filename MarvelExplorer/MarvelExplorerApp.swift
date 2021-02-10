import SwiftUI

@main
struct MarvelExplorerApp: App {

    var model: PagedContent<Character> = {
        var networkController: MarvelNetworkController = DefaultNetworkController(networkDispatcher: URLSession.shared)
        var getCharacterWorker = GetCharactersWorker(networkController: networkController)
        var pagedContent = PagedContent<Character>(limit: 10, worker: getCharacterWorker.eraseToAnyGetPagedContentWorker())
        return pagedContent
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                CharactersView()
                .environmentObject(model)
                .navigationBarTitle("Characteres")
            }
        }
    }
}
