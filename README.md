# Marvel Explorer
## Libraries
* [SDWebImage](https://github.com/SDWebImage/SDWebImageSwiftUI)
SDWebImageSwiftUI is a SwiftUI image loading framework, which based on  [SDWebImage](https://github.com/SDWebImage/SDWebImage) .

## Architecture: SwiftUI + Combine
This project uses SwiftUI + Combine to provide a more functional reactive architecture.
Instead use some view state layer, this project tries to bind model directly to the view maintaining the sync between model and view layers.

## API
Insert your API Keys on `MarvelAPI` file like this:
```
static let publicKey = "123"
static let privateKey = "abc"
```
