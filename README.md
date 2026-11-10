# Tracker for Albion Online

A native iPhone companion app for Albion Online, built with SwiftUI. Look up players, browse recent PvP kill and death reports, and check item prices and gold price history across game regions.

I released the app on the App Store in August 2024. It reached **2,000+ downloads** before I removed it from the store.

## Features

- Search for players and view their stats, recent PvP reports, and equipment details.
- Browse item prices and chart gold price history for the West, East, and Europe regions.
- Search the item catalog by localized or English names and filter by tier and enchantment.
- Save favorite players and items on the device.

## How it works

- SwiftUI views are organized by feature, with view models handling screen state and data services handling requests. See [feature code](AlbionInfo/Core) and [data services](AlbionInfo/Services).
- A shared networking layer uses URLSession and Combine to fetch data from Albion Online's Game Info API and the Albion Online Data Project. See [networking](AlbionInfo/Utilities/NetworkManager.swift) and [regional endpoints](AlbionInfo/Models/Filter/Server.swift).
- Core Data persists favorites locally. See [player favorites](AlbionInfo/Utilities/FavoritePlayerDataManager.swift) and [item favorites](AlbionInfo/Utilities/FavoriteItemsDataManager.swift).

## Running locally

1. Clone this repository and open [AlbionInfo.xcodeproj](AlbionInfo.xcodeproj) in Xcode.
2. Let Xcode resolve the Swift Package Manager dependencies.
3. Select the `AlbionOnlineMarketTracker` scheme and an iPhone simulator running iOS 16 or later, then choose **Run**.

Player and market data depend on the availability of the external APIs.

## License

The source code is available under the [MIT License](LICENSE).
