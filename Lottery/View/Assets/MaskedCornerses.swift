import UIKit

func maskedCornerses(_ maskedCorners: MaskedCorners) -> CACornerMask {
    switch maskedCorners {
    case .none:
        return []
    
    case .topLeft:
        return .layerMinXMinYCorner
    case .topRight:
        return .layerMaxXMinYCorner
    case .bottomLeft:
        return .layerMinXMaxYCorner
    case .bottomRight:
        return .layerMaxXMaxYCorner
    
    case .top:
        return [maskedCornerses(.topLeft), maskedCornerses(.topRight)]
    case .left:
        return [maskedCornerses(.topLeft), maskedCornerses(.bottomLeft)]
    case .right:
        return [maskedCornerses(.topRight), maskedCornerses(.bottomRight)]
    case .bottom:
        return [maskedCornerses(.bottomLeft), maskedCornerses(.bottomRight)]
    
    case .exceptTopLeft:
        return [maskedCornerses(.topRight), maskedCornerses(.bottomLeft), maskedCornerses(.bottomRight)]
    case .exceptTopRight:
        return [maskedCornerses(.topLeft), maskedCornerses(.bottomLeft), maskedCornerses(.bottomRight)]
    case .exceptBottomLeft:
        return [maskedCornerses(.topLeft), maskedCornerses(.topRight), maskedCornerses(.bottomRight)]
    case .exceptBottomRight:
        return [maskedCornerses(.topLeft), maskedCornerses(.topRight), maskedCornerses(.bottomLeft)]
    
    case .all:
        return [maskedCornerses(.topLeft), maskedCornerses(.topRight), maskedCornerses(.bottomLeft), maskedCornerses(.bottomRight)]
    }
}
enum MaskedCorners: String {
    case none
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    case top
    case left
    case right
    case bottom
    
    case exceptTopLeft
    case exceptTopRight
    case exceptBottomLeft
    case exceptBottomRight
    
    case all
}
