import SwiftUI
import Combine

protocol GridViewItemModel {
    var id: Int { get }
    var name: String { get }
    var url: URL? { get }
}

struct GridView<Element, DetailContent>: View where Element: GridViewItemModel, DetailContent: View {

    private let columns: [GridItem] = [.init(.flexible(), spacing: 16), .init(.flexible())]

    let elements: [Element]
    let isFull: Bool
    let load: () -> Void
    let detailContent: (Element) -> DetailContent

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(elements, id: \.id) { item in
                    NavigationLink(destination: detailContent(item)) {
                        GridCell(name: item.name, url: item.url)
                    }
                }

                if !isFull {
                    Text("loading...")
                        .onAppear {
                            load()
                        }
                }
            }
        }
    }
}

#if DEBUG
struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView<Character, Text>(elements: PagedContent.mockCharacter.results,
                                  isFull: false,
                                  load: {},
                                  detailContent: { Text($0.name)})
    }
}
#endif
