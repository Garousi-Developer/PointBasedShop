struct Settings: Decodable {
    let debuggingIsEnabled: Bool
    
    enum CodingKeys: String, CodingKey {
        case debuggingIsEnabled = "Debugging Is Enabled"
    }
}
