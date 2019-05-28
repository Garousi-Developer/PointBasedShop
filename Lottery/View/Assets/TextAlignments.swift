import UIKit

func textAlignments(_ textAlignment: TextAlignment) -> NSTextAlignment {
    switch textAlignment {
    case .left:
        return .left
    case .center:
        return .center
    case .right:
        return .right
    }
}
enum TextAlignment: String {
    case left
    case center
    case right
}
