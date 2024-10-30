// MARK: - Tests/RainbowTextAnimationTests/RainbowTextTests.swift
import Testing
import SwiftUI
@testable import Rainbow_Text_Animation

@Suite("RainbowTextModifier Tests")
struct RainbowTextModifierTests {
    @Test("Default initialization values are correct")
    @MainActor
    func testDefaultInitialization() async throws {
        let modifier = RainbowTextModifier()
        #expect(modifier.saturation ~= 1.0)
        #expect(modifier.lightness ~= 0.65)
        #expect(modifier.animated)
    }
    
    @Test("Custom initialization values are set correctly")
    @MainActor
    func testCustomInitialization() async throws {
        let modifier = RainbowTextModifier(
            saturation: 0.8,
            lightness: 0.7,
            animated: false
        )
        #expect(modifier.saturation ~= 0.8)
        #expect(modifier.lightness ~= 0.7)
        #expect(!modifier.animated)
    }
    
    @Test("Saturation value is clamped between 0 and 1")
    @MainActor
    func testSaturationClamping() async throws {
        let modifierLow = RainbowTextModifier(saturation: -0.5)
        let modifierHigh = RainbowTextModifier(saturation: 1.5)
        
        #expect(modifierLow.saturation ~= 0.0)
        #expect(modifierHigh.saturation ~= 1.0)
    }
    
    @Test("Lightness value is clamped between 0 and 1")
    @MainActor
    func testLightnessClamping() async throws {
        let modifierLow = RainbowTextModifier(lightness: -0.5)
        let modifierHigh = RainbowTextModifier(lightness: 1.5)
        
        #expect(modifierLow.lightness ~= 0.0)
        #expect(modifierHigh.lightness ~= 1.0)
    }
}

@Suite("Rainbow Colors Tests")
struct RainbowColorsTests {
    @Test("Color components are extracted correctly")
    func testColorComponents() async throws {
        let color = Color(hue: 0.5, saturation: 0.8, brightness: 0.7)
        let components = color.components
        
        #expect(components.hue ~= 0.5)
        #expect(components.saturation ~= 0.8)
        #expect(components.brightness ~= 0.7)
    }
    
    @Test("Color values are clamped correctly")
    func testValueClamping() async throws {
        let value = 1.5.clamped(to: 0...1)
        #expect(value ~= 1.0)
        
        let negativeValue = (-0.5).clamped(to: 0...1)
        #expect(negativeValue ~= 0.0)
    }
}

@Suite("View Modifier Tests")
struct ViewModifierTests {
    @Test("Rainbow text modifier applies correctly")
    @MainActor
    func testModifierApplication() async throws {
        // Create a view with the modifier
        let view = Text("Test")
            .rainbowText(
                saturation: 0.8,
                lightness: 0.7,
                animated: false
            )
        
        // Create a mirror of the view to inspect its properties
        let mirror = Mirror(reflecting: view)
        
        // Verify the modifier is applied by checking the modifier chain
        let hasRainbowModifier = mirror.children.contains { child in
            String(describing: type(of: child.value))
                .contains("RainbowTextModifier")
        }
        
        #expect(hasRainbowModifier)
    }
    
    @Test("Rainbow text modifier preserves view hierarchy")
    @MainActor
    func testViewHierarchy() async throws {
        let originalText = "Test"
        let view = Text(originalText)
            .rainbowText()
        
        // Use Mirror to traverse the view hierarchy
        func findText(in value: Any) -> String? {
            let mirror = Mirror(reflecting: value)
            
            // Check if current value is a Text view
            if let textView = value as? Text {
                return String(describing: textView)
            }
            
            // Recursively check children
            for child in mirror.children {
                if let found = findText(in: child.value) {
                    return found
                }
            }
            
            return nil
        }
        
        let foundText = findText(in: view)
        #expect(foundText != nil)
        #expect(String(describing: foundText!).contains(originalText))
    }
}

// MARK: - Helper Extensions for Testing
extension Double {
    static func ~=(lhs: Self, rhs: Self) -> Bool {
        abs(lhs - rhs) < 0.001
    }
}

// MARK: - Preview Provider
#Preview("Rainbow Text Examples") {
    VStack(spacing: 20) {
        Group {
            Text("Default Rainbow")
                .font(.largeTitle)
                .rainbowText()
            
            Text("Static Rainbow")
                .font(.title)
                .rainbowText(animated: false)
            
            Text("Custom Colors")
                .font(.title2)
                .rainbowText(saturation: 0.8, lightness: 0.7)
        }
        .padding(.vertical, 10)
        
        Divider()
        
        Group {
            Text("Low Saturation")
                .rainbowText(saturation: 0.3)
            
            Text("High Lightness")
                .rainbowText(lightness: 0.9)
            
            Text("Combined Custom")
                .rainbowText(
                    saturation: 0.6,
                    lightness: 0.8,
                    animated: true
                )
        }
    }
    .padding()
}
