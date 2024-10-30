import SwiftUI

public struct RainbowTextModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    let saturation: Double
    let lightness: Double
    let animated: Bool
    
    public init(saturation: Double = 1.0, lightness: Double = 0.65, animated: Bool = true) {
        self.saturation = saturation.clamped(to: 0...1)
        self.lightness = lightness.clamped(to: 0...1)
        self.animated = animated
    }
    
    var rainbowColors: [Color] {
        stride(from: 0.0, through: 1.0, by: 0.125).map { hue in
            Color(hue: hue, saturation: saturation, brightness: lightness)
        }
    }
    
    public func body(content: Content) -> some View {
        content
            .foregroundStyle(
                .linearGradient(
                    colors: rainbowColors,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .mask(content)
            .overlay(shimmerOverlay)
    }
    
    @ViewBuilder
    private var shimmerOverlay: some View {
        if animated {
            GeometryReader { geometry in
                LinearGradient(
                    colors: [
                        .clear,
                        .white.opacity(0.2),
                        .clear
                    ],
                    startPoint: UnitPoint(x: phase - 0.2, y: 0.5),
                    endPoint: UnitPoint(x: phase + 0.2, y: 0.5)
                )
                .blendMode(.plusLighter)
                .onAppear {
                    withAnimation(
                        .linear(duration: 3)
                        .repeatForever(autoreverses: false)
                    ) {
                        phase = 1.2
                    }
                }
            }
        }
    }
}
