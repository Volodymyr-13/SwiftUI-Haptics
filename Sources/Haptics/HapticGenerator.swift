import SwiftUI

public class HapticGenerator {
    static public var `default` = HapticGenerator()
    
    #if os(watchOS)
    internal let device = WKInterfaceDevice.current()
    #endif
    
    @AppStorage("haptics") var hapticEnabled = true
    
    #if os(iOS)
    public func shouldTriggerHaptic() -> Bool {
        return hapticEnabled // Check hapticEnabled state here
    }
    
    /// Triggers a selection feedback programmatically.
    ///
    /// You can also use ``.haptics(onChangeOf:)`` on your `View`.
    func hapticFeedbackOccurred() {
        if shouldTriggerHaptic() {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    /// Triggers a notification feedback programmatically.
    ///
    /// You can also use ``.haptics(onChangeOf:type:)`` on your `View`.
    func hapticFeedbackOccurred(type: UINotificationFeedbackGenerator.FeedbackType) {
        if shouldTriggerHaptic() {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
    
    /// Triggers an impact feedback programmatically.
    ///
    /// You can also use ``.haptics(onChangeOf:type:)`` on your `View`.
    func hapticFeedbackOccurred(type: UIImpactFeedbackGenerator.FeedbackStyle) {
        if shouldTriggerHaptic() {
            let generator = UIImpactFeedbackGenerator(style: type)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    #elseif os(watchOS)
    public func shouldTriggerHaptic() -> Bool {
        return hapticEnabled // Check hapticEnabled state here
    }
    
    /// Triggers a haptic feedback programmatically.
    ///
    /// If you want to perform different kinds of feedbacks accordingly, this function might be useful.
    ///
    /// You can also use ``.haptics(onChangeOf:type:)`` on your `View`.
    func hapticFeedbackOccurred(type: WKHapticType) {
        if shouldTriggerHaptic() {
            device.play(type)
        }
    }
    #endif
}
let generator = HapticGenerator.default
