import SwiftUI

struct CharacterView: View {

    let character: Character

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            WebImage(url: character.thumbnailURL)
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(6)
                .clipped()
                .shadow(radius: 10)
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                    .frame(height: 50, alignment: .leading)
                Text(character.resultDescription)
                    .font(.caption)
            }
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .topLeading)
        .navigationBarTitle(character.name)
    }
}

#if DEBUG
struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: .init(id: 0,
                                       name: "Aladin",
                                       resultDescription: "Melhor heroi ever!",
                                       modified: Date(),
                                       resourceURI: nil,
                                       urls: [],
                                       thumbnailURL: URL(string: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark.png"),
                                       comics: nil,
                                       stories: nil,
                                       events: nil,
                                       series: nil))
    }
}
#endif
