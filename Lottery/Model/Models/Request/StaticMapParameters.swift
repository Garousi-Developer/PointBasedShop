struct StaticMapParameters: Encodable {
    let center: String
    let zoom: Int = 15
    let size: String = "640x320"
    let scale: Int = 2
    let language: String = languageIsPersian ? "fa" : "en"
    let key: String = "AIzaSyCsyZFuBIS4n33ye6THBYz7DHEb6C9qCeg"
}
