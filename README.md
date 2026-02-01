# .app Bundles, Swift Way

Have you ever wanted to read an `.app`'s data, but it was too annoying?

Enter `ApplicationInspector`, the one-stop-shop for reading Application Bundles.

> [!NOTE]
> This library is still in development. We recommend that you use of the version tags to pin the version you will be using to prevent broken behavior.

## Usage

The library provides two objects, an `Application` struct, which represents an Application Bundle, and an `ApplicationInspector` class, which is used for reading all installed Applications.

### Initializing a standalone Application structure

To initialize and `Application` struct, use the provided initializer, passing in the complete URL of the Application Bundle:

```swift
try Application.init(from: URL)
```

The initializer for `Application` is throwable and provides the following errors:

```swift
/// The provided URL does not exist in the filesystem
case providedURLDoesNotExist(checkedPath: String)

/// The provided URL is not readable, there might be misconfigured permissions
case applicationExecutableNotReadable(checkedPath: String)

/// The provided URL exists and whatever it points to is readable, but it is not an Application Bundle
case couldNotReadBundle(applicationPath: String)

/// Could not read the information dictionary from the provided App Bundle. Either it is not readable, or it is not formatted correctly
case couldNotGetInfoDictionary

/// Could not get the name of the app from the provided Application Bundle
case couldNotGetMandatoryAppInformation(_ mandatoryInformation: MandatoryAppInformation)
```

Once an `Application` object is created, you gain access to the following metadata about the application:

- `name`: The name of the app
- `iconPath` (optional): Full path to the app's icon
- `iconImage` (optional): The app's icon in SwiftUI's `Image` format

### Reading the entire Applications folder

To read the entire Applications folder, initialize the `ApplicationInspector` class:

```swift
let testApplicationInspector: ApplicationInspector = try await .init()
```

The `ApplicationInspector` class defines a `installedApplications` property, which contains an array of the loaded Applications, represented by a `ApplicationsListingResult` typealias. This typealias contains an `Application` if the reading of that Application was successful, or an `Application.ApplicationInitializationError` if the reading of that application failed.

The initializer for `ApplicationInspector` is throwable and provides the following errors:

```swift
/// The library does not have permissions to read the Applications directory
case couldNotReadContentsOfApplicationsDirectory(error: Error)
```

## License

Unless otherwise specified or given my explicit permission, this software is licensed under [AGPLv3](https://www.gnu.org/licenses/agpl-3.0.html).
