import Foundation

#if DEBUG
extension CharacterResponse {
    static let mock = CharacterResponse(id: 0,
                                        name: "Characeter",
                                        description: "",
                                        modified: "",
                                        resourceURI: nil,
                                        urls: [],
                                        thumbnail: ThumbnailResponse(path: "https://swiftui-lab.com/wp-content/uploads/2019/11/companion-dark",
                                                                     extension: "png"))
}
#endif
