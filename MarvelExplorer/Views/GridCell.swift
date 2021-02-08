import SwiftUI

struct GridCell: View {

    let name: String
    let url: URL?

    var body: some View {
        VStack(alignment: .center, spacing: .zero) {
            WebImage(url: url)
                .scaledToFit()
                .frame(height: 200)
            Rectangle()
                .frame(height: 4)
                .foregroundColor(.red)
            Text(name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(height: 46, alignment: .topLeading)
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .padding(8)
        }.background(Color.black)
        .cornerRadius(6)
        .shadow(radius: 2)
    }
}

#if DEBUG
struct GridCell_Previews: PreviewProvider {
    static var previews: some View {
        GridCell(name: "Iron Man - It will Survive",
                 url: URL(string: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark.png")!)
            .previewLayout(.fixed(width: 300, height: 400))
    }
}
#endif
