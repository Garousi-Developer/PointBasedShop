import Foundation

func delay(_ duration: TimeInterval, didEnd: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: .now() + duration,
        execute: didEnd
    )
}
