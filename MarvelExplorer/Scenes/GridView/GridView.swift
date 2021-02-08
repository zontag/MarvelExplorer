import SwiftUI
import Combine

protocol GridViewItemModel {
    var id: Int { get }
    var name: String { get }
    var url: URL? { get }
}

struct GridView<Element, DetailContent>: View where Element: GridViewItemModel, DetailContent: View {

    var detailContent: (Element) -> DetailContent

    @EnvironmentObject var model: PagedContent<Element>

    private let columns: [GridItem] = [.init(.flexible(), spacing: 16), .init(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(model.results, id: \.id) { item in
                    NavigationLink(destination: detailContent(item)) {
                        GridCell(name: item.name, url: item.url)
                    }
                }

                if !model.isFull {
                    Text("loading...")
                        .onAppear {
                            model.load()
                        }
                }
            }.padding()
            .onAppear {
                model.load()
            }
        }
        .alert(isPresented: $model.isError) {
            Alert(title: Text("Ops.."),
                  message: Text("An error occurred while trying to retrieve data"),
                  dismissButton: .default(Text("Retry"), action: model.load))
        }
    }
}

#if DEBUG
struct GridView_Previews: PreviewProvider {
    static let mockGetPagedContent = { (limit: Int, offset: Int) -> AnyPublisher<PagedContent<Character>, Error> in

        var characters: [Character] = []
        for index in 0..<30 {
            characters.append(.init(id: index,
                                    name: "Characeter \(index)",
                                    resultDescription: "",
                                    modified: Date(),
                                    resourceURI: nil,
                                    urls: [],
                                    thumbnailURL: URL(string: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark.png"),
                                    comics: nil,
                                    stories: nil,
                                    events: nil,
                                    series: nil))
        }

        return Result<PagedContent<Character>, Error>
            .Publisher(PagedContent<Character>(offset: 0,
                                               limit: 0,
                                               total: 0,
                                               count: 0,
                                               results: characters))
            .eraseToAnyPublisher()
    }

    static var pagedContent: PagedContent<Character> {
        let model = PagedContent<Character>(limit: 30)
        model.getPagedContent = mockGetPagedContent
        return model
    }

    static var previews: some View {
        GridView<Character, Text>(detailContent: { Text($0.name)})
            .environmentObject(pagedContent)
    }
}
#endif
