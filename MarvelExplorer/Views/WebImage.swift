import SwiftUI
import SDWebImageSwiftUI

struct WebImage: View {

    let url: URL?

    var body: some View {
        SDWebImageSwiftUI.WebImage(url: url)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

#if DEBUG
struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(url: URL(string: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark.png")!)
    }
}
#endif
