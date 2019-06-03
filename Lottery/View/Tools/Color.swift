import UIKit

func color(ofProgress progress: Float) -> UIColor {
    if progress < 1/3 {
        return colors(.green)
    }
    else if progress < 2/3 {
        return colors(.primary)
    }
    else {
        return colors(.red)
    }
}
