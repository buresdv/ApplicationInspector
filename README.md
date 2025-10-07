# Read an .app bundle's metadata in a modern Swift way

Use this library to read metadata about an
`.app` bundle in a modern Swift way.

Still WIP

## Usage

The library provides as `Application` struct, initialized by passing in a `URL` of the `.app`:

```swift
try Application.init(from: URL)
```

The initializer is failable:

```swift
case applicationExecutableNotReadable(checkedPath: String)
case couldNotAccessApplicationExecutable(error: Error)
case couldNotReadBundle(applicationPath: String)
case couldNotGetInfoDictionary
case couldNotGetMandatoryAppInformation(_ mandatoryInformation: MandatoryAppInformation)
```

Once an `Application` object is created, you gain access to the following metadata about the application:

- `name`: The name of the app
- `iconPath` (optional): Full path to the app's icon
- `iconImage` (optional): The app's icon in SwiftUI's `Image` format

## License

Unless otherwise specified or given my explicit permission, this software is licensed under [AGPLv3](https://www.gnu.org/licenses/agpl-3.0.html).
