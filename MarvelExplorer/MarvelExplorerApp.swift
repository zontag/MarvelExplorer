import SwiftUI

@main
struct MarvelExplorerApp: App {

    var viewModel: PagedContent<Character> = {
        var networkController: MarvelNetworkController = DefaultNetworkController(networkDispatcher: URLSession.shared)
        var getCharacterWorker = GetCharactersWorker(networkController: networkController)
        var pagedContent = PagedContent<Character>(limit: 10)
        pagedContent.getPagedContent = getCharacterWorker.callAsFunction
//        var viewModel = GridViewModel(getCharacterWorker.callAsFunction)
        return pagedContent
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                GridView<Character, CharacterView>(detailContent: { CharacterView(character: $0) })
                .environmentObject(viewModel)
                .navigationBarTitle("Characteres")
            }
        }
    }
}
