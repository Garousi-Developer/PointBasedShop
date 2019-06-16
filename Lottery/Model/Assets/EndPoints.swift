import Alamofire

func endPoints(_ endPointName: EndPointName) -> EndPoint {
    switch endPointName {
    // Login:
    case .login(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/login",
            response: User.self
        )
    case .registerFirstStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/register/step-one"
        )
    case .registerSecondStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/register/step-two"
        )
    case .registerThirdStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/register/step-three",
            response: User.self
        )
    
    // Home:
    case .home:
        return EndPoint(
            url: "/home",
            response: Home.self
        )
    case .closestOffers(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/nearby-offers",
            response: ClosestOffers.self
        )
    case .city(let id):
        return EndPoint(
            url: "/city/\(id)",
            response: CityDetails.self
        )
    case .shoppingCenter(let id):
        return EndPoint(
            url: "/shop/\(id)",
            response: ShoppingCenterDetails.self
        )
    
    // Awards:
    case .awards(let parameters):
        return EndPoint(
            parameters: parameters,
            encoding: URLEncoding.default,
            url: "/point-purchase",
            response: Awards.self
        )
    
    // Google Maps:
    case .staticMap(let parameters):
        return EndPoint(
            parameters: parameters,
            encoding: URLEncoding.default,
            baseURL: googleMapsBaseURL,
            url: "/staticmap"
        )
    }
}
enum EndPointName {
    // Login:
    case login(parameters: LoginParameters)
    case registerFirstStep(parameters: RegisterFirstStepParameters)
    case registerSecondStep(parameters: RegisterSecondStepParameters)
    case registerThirdStep(parameters: RegisterThirdStepParameters)
    
    // Home:
    case home
    case closestOffers(parameters: ClosestOffersParameters)
    case city(id: Int)
    case shoppingCenter(id: Int)
    
    // Awards:
    case awards(parameters: ClosestOffersParameters)
    
    // Google Maps:
    case staticMap(parameters: StaticMapParameters)
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
        baseURL: String = loyaltyBaseURL,
        url: String,
        response: Decodable.Type? = nil
    ) {
        self.method = method
        self.parameters = parameters?.json
        self.encoding = encoding
        self.url = baseURL + url
        self.response = response
        if let token = UserDefaults.standard.string(forKey: "token") {
            self.headers = [
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
        else {
            self.headers = [
                "Accept": "application/json"
            ]
        }
    }
}

private let loyaltyBaseURL = "http://learngroup.ir/api/v1"
private let googleMapsBaseURL = "https://maps.googleapis.com/maps/api"
