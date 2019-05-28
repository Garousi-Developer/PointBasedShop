import Alamofire

func endPoints(_ endPointName: EndPointName) -> EndPoint {
    return EndPoint(url: "")
}
enum EndPointName {
    
}

struct EndPoint {
    let method: HTTPMethod
    let headers: HTTPHeaders?
    let parameters: Parameters?
    let encoding: ParameterEncoding
    let url: URLConvertible
    let response: Decodable.Type?
    
    init(
        method: HTTPMethod = .get,
        headers: HTTPHeaders? = ["Accept": "application/json"],
        parameters: Encodable? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        url: String,
        response: Decodable.Type? = nil
    ) {
        self.method = method
        self.headers = headers
        self.parameters = parameters?.json
        self.encoding = encoding
        self.url = baseURL + url
        self.response = response
    }
}

private let baseURL = ""
