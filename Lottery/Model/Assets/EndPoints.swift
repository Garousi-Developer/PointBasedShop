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
    case .retrievePasswordFirstStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/forget/step-one"
        )
    case .retrievePasswordSecondStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/forget/step-two",
            response: RetrievePasswordSecondStep.self
        )
    case .retrievePasswordThirdStep(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/forget/step-three",
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
            response: Products.self
        )
    case .filter(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/search",
            response: Products.self
        )
    case .filterScopes:
        return EndPoint(
            url: "/search",
            response: FilterScopes.self
        )
    case .product(let id):
        return EndPoint(
            url: "/product/\(id)",
            response: ProductDetailses.self
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
    case .brand(let id):
        return EndPoint(
            url: "/brand/\(id)",
            response: BrandDetails.self
        )
    
    // Cart:
    case .cart:
        return EndPoint(
            url: "/cart",
            response: Cart.self
        )
    case .updateCart(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/cart"
        )
    case .removeCart(let id):
        return EndPoint(
            method: .delete,
            url: "/cart/\(id)"
        )
    
    // Order:
    case .addOrder(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/order"
        )
    case .orders:
        return EndPoint(
            url: "/order",
            response: Order.self
        )
    case .orderItems(let id):
        return EndPoint(
            url: "/order/\(id)",
            response: OrderDetails.self
        )
    
    // Awards:
    case .awards(let parameters):
        return EndPoint(
            parameters: parameters,
            encoding: URLEncoding.default,
            url: "/point-purchase",
            response: Awards.self
        )
    case .checkIn(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/point-loyalty"
        )
    case .claimPoints(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/point-purchase"
        )
    
    // Profile:
    case .profile:
        return EndPoint(
            url: "/profile",
            response: Profile.self
        )
    case .invite(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/referral"
        )
    case .updateProfile(let parameters):
        return EndPoint(
            method: .put,
            parameters: parameters,
            url: "/profile"
        )
    case .updateNumber(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/profile/change-username"
        )
    case .addresses:
        return EndPoint(
            url: "/addresses",
            response: NewAddress.self
        )
    case .addAddress(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/addresses",
            response: NewAddress.self
        )
    case .editAddress(let id, let parameters):
        return EndPoint(
            method: .put,
            parameters: parameters,
            url: "/addresses/\(id)"
        )
    case .removeAddress(let id):
        return EndPoint(
            method: .delete,
            url: "/addresses/\(id)"
        )
    
    // Favorites:
    case .addFavorite(let parameters):
        return EndPoint(
            method: .post,
            parameters: parameters,
            url: "/wishlist"
    )
    case .removeFavorite(let parameters):
        return EndPoint(
            method: .delete,
            parameters: parameters,
            url: "/wishlist/collection"
        )
    case .favorites:
        return EndPoint(
            url: "/wishlist",
            response: Favorites.self
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
    case retrievePasswordFirstStep(parameters: RetrievePasswordFirstStepParameters)
    case retrievePasswordSecondStep(parameters: RetrievePasswordSecondStepParameters)
    case retrievePasswordThirdStep(parameters: RetrievePasswordThirdStepParameters)
    case registerFirstStep(parameters: RegisterFirstStepParameters)
    case registerSecondStep(parameters: RegisterSecondStepParameters)
    case registerThirdStep(parameters: RegisterThirdStepParameters)
    
    // Home:
    case home
    case closestOffers(parameters: ClosestOffersParameters)
    case filter(parameters: FilterParameters)
    case filterScopes
    case product(id: Int)
    case city(id: Int)
    case shoppingCenter(id: Int)
    case brand(id: Int)
    
    // Cart:
    case cart
    case removeCart(id: Int)
    case updateCart(parameters: UpdateCartParameters)
    
    // Order:
    case addOrder(parameters: AddOrderParameters)
    case orders
    case orderItems(id: Int)
    
    // Awards:
    case awards(parameters: ClosestOffersParameters)
    case checkIn(parameters: CheckInParameters)
    case claimPoints(parameters: ClaimPointsParameters)
    
    // Profile:
    case profile
    case invite(parameters: InviteParameters)
    case updateProfile(parameters: UpdateProfileParameters)
    case updateNumber(parameters: UpdateNumberParameters)
    case addresses
    case addAddress(parameters: AddAddressParameters)
    case editAddress(id: Int, parameters: AddAddressParameters)
    case removeAddress(id: Int)
    
    // Favorites:
    case addFavorite(parameters: AddFavoriteParameters)
    case removeFavorite(parameters: RemoveFavoriteParameters)
    case favorites
    
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

private let loyaltyBaseURL = "https://mallsconnect.com/api/v1"
private let googleMapsBaseURL = "https://maps.googleapis.com/maps/api"
