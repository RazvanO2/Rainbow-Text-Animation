import SwiftUI
extension Comparable {
    func clamped(to range: ClosedRange<Self>) -> Self {
        min(max(self, range.lowerBound), range.upperBound)
    }
}

extension Color {
    var components: (hue: Double, saturation: Double, brightness: Double) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        
        #if os(iOS) || os(tvOS) || os(watchOS)
        UIColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        #else
        NSColor(self).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
        #endif
        
        return (Double(hue), Double(saturation), Double(brightness))
    }
    
    var hue: Double { components.hue }
    var saturation: Double { components.saturation }
    var brightness: Double { components.brightness }
}

public extension View {
    func rainbowText(
        saturation: Double = 1.0,
        lightness: Double = 0.65,
        animated: Bool = true
    ) -> some View {
        modifier(RainbowTextModifier(
            saturation: saturation,
            lightness: lightness,
            animated: animated
        ))
    }
}
