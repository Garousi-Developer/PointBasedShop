import Foundation

func durations(_ duration: Duration) -> TimeInterval {
    switch duration {
    case .epsilon:
        return 0.01
    case .interaction:
        return 0.2
    case .textField:
        return 0.35
    }
}
enum Duration: String {
    case epsilon
    case interaction
    case textField
}
