import UIKit

struct Container {
    let type: ContainerType
    let picture: UIImage!
    let logoPicture: UIImage!
    let name: String
}

enum ContainerType {
    case city
    case shoppingCenter
    case brand
}
