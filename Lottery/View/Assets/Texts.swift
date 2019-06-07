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
    
    // Container:
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
    
    // Awards:
    case .shoppingCenterName:
        return "نام مرکز خرید"
    case .pointsAmount:
        return "مقدار امتیاز"
    case .percentageAmount:
        return "مقدار درصد"
    
    case .welcomeToXShoppingCenter:
        return "به مرکز خرید \(texts(.shoppingCenterName)) خوش آمدید"
    case .tapCheckInToClaimXLoyaltyPoints:
        return "برای کسب \(texts(.pointsAmount)) امتیاز وفاداری دکمه ثبت حضور را بزنید"
    case .checkIn:
        return "ثبت حضور"
    case .takeYourTodaysInvoicesToXShoppingCenterCounter:
        return """
        فاکتورهای امروز خود را به پیشخوان مرکز خرید \(texts(.shoppingCenterName)) ببرید
        و \(texts(.percentageAmount)) درصد کل مبلغ خرید خود را به عنوان امتیاز کسب کنید
        """
    case .claimPoints:
        return "کسب امتیاز"
    
    // Claim Points:
    case .pleaseHaveAllYourTodaysInvoicesStampedBySalesman:
        return "لطفا همه فاکتورهای امروز خود را توسط فروشنده مهر کنید و اجازه دهید مبلغ خرید و کد خود را وارد کند تا امتیازتان را کسب کنید"
    case .purchaseAmountInTomans:
        return "مبلغ خرید به تومان"
    case .employeeId:
        return "شناسه کارمند"
    case .secretToken:
        return "کد محرمانه"
    case .submit:
        return "تایید"
    
    // Login:
    case .login:
        return "ورود"
    case .mobileNumber:
        return "شماره موبایل"
    case .invalidMobileNumber:
        return "شماره موبایل معتبر نیست"
    case .password:
        return "رمز عبور"
    case .shortPassword:
        return "رمز عبور باید حداقل ۴ کاراکتر باشد"
    case .register:
        return "عضویت"
    
    // Retrieve Password First Step:
    case .retrievePassword:
        return "بازیابی رمز عبور"
    case .firstStepOfRetrievePassword:
        return "مرحله اول بازیابی رمز"
    case .firstStep:
        return "مرحله اول"
    case .retrieveCode:
        return "بازیابی رمز"
    
    // Retrieve Password Second Step:
    case .secondStepOfRetrievePassword:
        return "مرحله دوم بازیابی رمز"
    case .verificationCode:
        return "کد تایید"
    case .invalidVerificationCode:
        return "کد تایید باید ۶ رقم باشد"
    case .secondStep:
        return "مرحله دوم"
    
    // Retrieve Password Third Step:
    case .thirdStepOfRetrievePassword:
        return "مرحله سوم بازیابی رمز"
    
    //  Register First Step:
    case .firstStepOfRegister:
        return "مرحله اول عضویت"
    case .nextStep:
        return "مرحله بعد"
    
    //  Register Second Step:
    case .secondStepOfRegister:
        return "مرحله دوم عضویت"
    
    //  Register Third Step:
    case .userAgreement:
        return "توافق نامه کاربری"
    case .privacyPolicy:
        return "سیاست حفظ حریم خصوصی"
    
    case .thirdStepOfRegister:
        return "مرحله سوم عضویت"
    case .optionalFirstName:
        return "نام (اختیاری)"
    case .optionalLastName:
        return "نام خانوادگی (اختیاری)"
    case .optionalEmail:
        return "ایمیل (اختیاری)"
    case .invalidEmail:
        return "ایمیل معتبر نیست"
    case .iHaveReadAndAcceptUserAgreementAndPrivacyPolicy:
        return "\(texts(.userAgreement)) و \(texts(.privacyPolicy)) را خوانده و قبول دارم"
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
    
    // Container:
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
    
    // Awards:
    case shoppingCenterName
    case pointsAmount
    case percentageAmount
    
    case welcomeToXShoppingCenter
    case tapCheckInToClaimXLoyaltyPoints
    case checkIn
    case takeYourTodaysInvoicesToXShoppingCenterCounter
    case claimPoints
    
    // Claim Points:
    case pleaseHaveAllYourTodaysInvoicesStampedBySalesman
    case purchaseAmountInTomans
    case employeeId
    case secretToken
    case submit
    
    // Login:
    case login
    case mobileNumber
    case invalidMobileNumber
    case password
    case shortPassword
    case register
    
    // Retrieve Password First Step:
    case retrievePassword
    case firstStepOfRetrievePassword
    case firstStep
    case retrieveCode
    
    // Retrieve Password Second Step:
    case secondStepOfRetrievePassword
    case verificationCode
    case invalidVerificationCode
    case secondStep
    
    // Retrieve Password Third Step:
    case thirdStepOfRetrievePassword
    
    // Register First Step:
    case firstStepOfRegister
    case nextStep
    
    // Register Second Step:
    case secondStepOfRegister
    
    // Register Third Step:
    case userAgreement
    case privacyPolicy
    
    case thirdStepOfRegister
    case optionalFirstName
    case optionalLastName
    case optionalEmail
    case invalidEmail
    case iHaveReadAndAcceptUserAgreementAndPrivacyPolicy
}
