import Foundation

func delay(_ duration: TimeInterval, didComplete: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(
        deadline: .now() + duration,
        execute: didComplete
    )
}
func timerDelay(_ duration: TimeInterval, didComplete: @escaping () -> Void) {
    Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { (_) in
        didComplete()
    }
}
