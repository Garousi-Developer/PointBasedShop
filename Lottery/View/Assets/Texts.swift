func texts(_ text: Text) -> String {
    switch text {
    // Global:
    case .currency:
        return "تومان"
    case .empty:
        return ""
    case .more:
        return "بیشتر"
    case .number:
        return "تا"
    case .points:
        return "امتیاز"
    case .testText:
        return "متن آزمایشی"
    
    // Home:
    case .home:
        return "خانه"
    case .categories:
        return "دسته بندی ها"
    case .yourPoints:
        return "امتیاز شما"
    case .closestOffers:
        return "نزدیک ترین پیشنهادات"
    case .countryWidePostable:
        return "قابل ارسال به سراسر کشور"
    case .addToCart:
        return "افزودن به سبد خرید"
    case .addMore:
        return "افزودن"
    case .sold:
        return "فروخته شده"
    case .outOf:
        return "از"
    case .cities:
        return "شهرها"
    case .topShoppingCenters:
        return "برترین مراکز خرید"
    case .topBrands:
        return "برترین برندها"
    
    // City:
    case .viewMore:
        return "مشاهده بیشتر"
    case .viewLess:
        return "مشاهده کمتر"
    case .hottestOffers:
        return "داغ ترین پیشنهادات"
    
    // Favorites:
    case .favorites:
        return "علاقه مندی ها"
    
    // Cart:
    case .cart:
        return "سبد خرید"
    
    // Orders:
    case .orders:
        return "سفارشات"
    
    // Profile:
    case .profile:
        return "پروفایل"
    }
}
enum Text: String {
    // Global:
    case currency
    case empty
    case more
    case number
    case points
    case testText
    
    // Home:
    case home
    case categories
    case yourPoints
    case closestOffers
    case countryWidePostable
    case addToCart
    case addMore
    case sold
    case outOf
    case cities
    case topShoppingCenters
    case topBrands
    
    // City:
    case viewMore
    case viewLess
    case hottestOffers
    
    // Favorites:
    case favorites
    
    // Cart:
    case cart
    
    // Orders:
    case orders
    
    // Profile:
    case profile
}
