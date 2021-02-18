import SwiftUI

protocol DetailViewModel: ObservableObject {
    var thumbnailURL: URL? { get }
    var name: String? { get }
    var description: String? { get }
    var isFavorite: Bool { get }
    func favorite(_ isFavorite: Bool)
}

struct DetailView<Model>: View where Model: DetailViewModel {

    @ObservedObject var model: Model

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            WebImage(url: model.thumbnailURL)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
                .clipped()
                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text(model.name ?? "")
                    .font(.title)
                    .frame(height: 50, alignment: .leading)
                Text(model.description ?? "")
                    .font(.caption)
                Toggle("Favorite", isOn: toggleBinding())
            }
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle(model.name ?? "")
    }

    private func toggleBinding() -> Binding<Bool> {
        .init { () -> Bool in
            model.isFavorite
        } set: { value in
            model.favorite(value)
        }
    }
}

#if DEBUG
struct DetailView_Previews: PreviewProvider {

    final class Mock: DetailViewModel {

        var thumbnailURL: URL? = URL(string: "")

        var name: String? = "Character name"

        var description: String? = "Character description text"

        var isFavorite: Bool = false

        func favorite(_ isFavorite: Bool) {
            self.isFavorite = isFavorite
        }
    }

    static var previews: some View {
        DetailView(model: Mock())
    }
}
#endif
