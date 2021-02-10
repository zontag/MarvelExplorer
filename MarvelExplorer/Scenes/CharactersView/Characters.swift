import SwiftUI

struct CharactersView: View {

    @EnvironmentObject var model: PagedContent<Character>

    var body: some View {
        VStack {
            HStack {
            TextField("Search character", text: $model.filter)
                .padding(4)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8.0)

                Button("Done") {
                    hideKeyboard()
                }
            }.padding(.horizontal
        )

            GridView(elements: model.results,
                     isFull: model.isFull,
                     load: { model.load() },
                     detailContent: CharacterView.init)

        }.alert(isPresented: $model.isError) {
            Alert(title: Text("Ops.."),
                  message: Text("An error occurred while trying to retrieve data"),
                  dismissButton: .default(Text("Retry"), action: { model.load() }))
        }
    }
}

#if DEBUG
struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
            .environmentObject(PagedContent<Character>.mockCharacter)
    }
}
#endif
