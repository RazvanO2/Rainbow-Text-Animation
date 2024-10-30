# Rainbow Text Animation

A SwiftUI package that adds beautiful rainbow text effects to your views.

## Features

- Animated rainbow gradient text
- Customizable colors and animation
- Simple to use with SwiftUI modifiers
- Support for iOS 15+, macOS 12+, tvOS 15+, and watchOS 8+

![Rainbow Text Animation](https://github.com/RazvanO2/Rainbow-Text-Animation/example.png)
## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/RazvanO2/Rainbow-Text-Animation.git", from: "1.0.0")
]
```

Or add it through Xcode:
1. File > Add Packages...
2. Enter the package URL: `https://github.com/RazvanO2/Rainbow-Text-Animation.git`
3. Click Add Package

## Usage

```swift
import RainbowText

struct ContentView: View {
    var body: some View {
        Text("Rainbow Text")
            .rainbowText()
        
        // With custom parameters
        Text("Custom Rainbow")
            .rainbowText(
                saturation: 0.8,
                lightness: 0.7,
                animated: true
            )
    }
}
```

## Parameters

- `saturation`: Color saturation (0.0 to 1.0, default: 1.0)
- `lightness`: Color brightness (0.0 to 1.0, default: 0.65)
- `animated`: Enable/disable animation (default: true)

## License

MIT License
