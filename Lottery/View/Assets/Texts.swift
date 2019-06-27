func texts(_ text: Text) -> String {
    switch text {
    // Global:
    case .all:
        return "همه"
    case .count:
        return "عدد"
    case .currency:
        return "تومان"
    case .defaultLatitude:
        return "35.6892"
    case .defaultLongitude:
        return "51.3890"
    case .empty:
        return ""
    case .internalServerError:
        return "خطا در سرور"
    case .more:
        return "بیشتر"
    case .number:
        return "تا"
    case .points:
        return "امتیاز"
    case .testText:
        return "متن آزمایشی"
    case .pullToRefresh:
        return ""
    
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
    case .unregisteredMobileNumber:
        return "این شماره هنوز ثبت نام نکرده است"
    case .inactiveAccount:
        return "این حساب کاربری هنوز فعال نشده است"
    case .wrongCredentials:
        return "شماره موبایل یا رمز عبور اشتباه است"
    case .loginWithoutRegister:
        return "ورود بدون عضویت"
        
    // Retrieve Password First Step:
    case .retrievePassword:
        return "بازیابی رمز عبور"
    case .firstStepOfRetrievePassword:
        return "مرحله اول بازیابی رمز"
    case .nextStep:
        return "مرحله بعد"
    case .wrongVerificationCode:
        return "کد تایید اشتباه است"
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
        return "کد تایید باید ۵ رقم باشد"
    case .cancelRetrieveCodeAndLogin:
        return "لغو بازیابی رمز و ورود"
    case .secondStep:
        return "مرحله دوم"
        
    // Retrieve Password Third Step:
    case .thirdStepOfRetrievePassword:
        return "مرحله سوم بازیابی رمز"
    case .passwordRepeat:
        return "تکرار رمز عبور"
    case .unmatchedPasswords:
        return "رمز عبور و تکرار آن با هم مطابقت ندارند"
        
    //  Register First Step:
    case .register:
        return "عضویت"
    case .firstStepOfRegister:
        return "مرحله اول عضویت"
    case .alreadyRegistered:
        return "این شماره قبلا ثبت نام کرده است"
        
    //  Register Second Step:
    case .secondStepOfRegister:
        return "مرحله دوم عضویت"
    case .cancelRegisterAndLogin:
        return "لغو عضویت و ورود"
        
    //  Register Third Step:
    case .userAgreement:
        return "توافق نامه کاربری"
    case .privacyPolicy:
        return "سیاست حفظ حریم خصوصی"
        
    case .thirdStepOfRegister:
        return "مرحله سوم عضویت"
    case .firstName:
        return "نام"
    case .lastName:
        return "نام خانوادگی"
    case .optionalEmail:
        return "ایمیل (اختیاری)"
    case .invalidEmail:
        return "ایمیل معتبر نیست"
    case .iHaveReadAndAcceptUserAgreementAndPrivacyPolicy:
        return "\(texts(.userAgreement)) و \(texts(.privacyPolicy)) را خوانده و قبول دارم"
    
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
    
    // Filter Results:
    case .search:
        return "جستجو"
    
    // Filter:
    case .filter:
        return "فیلتر"
    case .unlocked:
        return "باز"
    case .locked:
        return "قفل"
    
    // Product:
    case .description:
        return "توضیحات"
    case .productDetails:
        return "جزئیات محصول"
    
    // Container:
    case .viewMore:
        return "مشاهده بیشتر"
    case .viewLess:
        return "مشاهده کمتر"
    case .hottestOffers:
        return "داغ ترین پیشنهادات"
    
    // Cart:
    case .cart:
        return "سبد خرید"
    case .numberOfProducts:
        return "تعداد محصولات"
    case .youWillEarnXPointsFromThisPurchase:
        return "شما از این خرید \(texts(.pointsAmount)) امتیاز به دست می آورید"
    case .totalPrice:
        return "قیمت کل"
    case .pricesAreTaxInclusive:
        return "قیمت ها با احتساب مالیات هستند"
    case .iDonateAllPurchasedProductsToCharity:
        return "همه محصولات خریداری شده را به خیریه اهدا می کنم"
    case .selectOneOfYourAddresses:
        return "یکی از آدرس های خود را انتخاب کنید"
    case .editAddress:
        return "ویرایش آدرس"
    case .pay:
        return "پرداخت"
    case .finalizeYourPurchase:
        return "خرید خود را نهایی کنید"
    
    // Finalize:
    case .purchaseFinalization:
        return "نهایی کردن خرید"
    
    // Awards:
    case .awards:
        return "جوایز"
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
    case .yourPointsSuccessfullyUpdated:
        return "امتیاز شما با موفقیت به روز رسانی شد"
    case .youEarnedPointsFromThisShoppingCenterForToday:
        return "شما امروز از این فروشگاه امتیاز دریافت کرده اید"
    case .takeYourTodaysInvoicesToXShoppingCenterCounter:
        return """
        فاکتورهای امروز خود را به پیشخوان مرکز خرید \(texts(.shoppingCenterName)) ببرید
        و با توجه به کل مبلغ خرید خود امتیاز کسب کنید
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
    case .invalidEmployeeId:
        return "شناسه کارمند باید ۴ رقم باشد"
    case .secretToken:
        return "کد محرمانه"
    case .submit:
        return "تایید"
    case .wrongEmployeeId:
        return "شناسه کارمند اشتباه است"
    case .wrongToken:
        return "کد محرمانه اشتباه است یا منقضی شده است"
    
    // Orders:
    case .orders:
        return "سفارشات"
    case .orderNumber:
        return "شماره سفارش"
    case .orderStatus:
        return "وضعیت سفارش"
    case .transactionNumber:
        return "شماره تراکنش"
    case .paymentDate:
        return "تاریخ پرداخت"
    case .hour:
        return "ساعت"
    case .address:
        return "آدرس"
    case .donatedToCharity:
        return "اهدا شده به خیریه"
    case .orderDetails:
        return "جزئیات سفارش"
    
    // Profile:
    case .profile:
        return "پروفایل"
    case .hello:
        return "سلام"
    case .userLevelAndPoints:
        return "سطح کاربری و امتیاز"
    case .inviteYourFriendsAndEarnPoints:
        return "دوستان خود را دعوت کنید و امتیاز بگیرید"
    case .logout:
        return "خروج"
    case .settings:
        return "تنظیمات"
    case .language:
        return "زبان"
    case .persian:
        return "فارسی"
    case .english:
        return "English"
    case .profileSettings:
        return "تنظیمات پروفایل"
    case .general:
        return "عمومی"
    case .howItWorks:
        return "چطور کار می کند"
    case .aboutUs:
        return "درباره ما"
    case .contactUs:
        return "ارتباط با ما"
    case .support:
        return "پشتیبانی"
    case .welcome:
        return "خوش آمدید"
    case .or:
        return "یا"
    
    // Favorites:
    case .favorites:
        return "علاقه مندی ها"
    case .removeAll:
        return "حذف همه"
    case .addAllToCart:
        return "افزودن همه به سبد خرید"
    }
}
enum Text: String {
    // Global:
    case all
    case count
    case currency
    case defaultLatitude
    case defaultLongitude
    case empty
    case internalServerError
    case more
    case number
    case points
    case testText
    case pullToRefresh
    
    // Login:
    case login
    case mobileNumber
    case invalidMobileNumber
    case password
    case shortPassword
    case unregisteredMobileNumber
    case inactiveAccount
    case wrongCredentials
    case loginWithoutRegister
    
    // Retrieve Password First Step:
    case retrievePassword
    case firstStepOfRetrievePassword
    case nextStep
    case wrongVerificationCode
    case firstStep
    case retrieveCode
    
    // Retrieve Password Second Step:
    case secondStepOfRetrievePassword
    case verificationCode
    case invalidVerificationCode
    case cancelRetrieveCodeAndLogin
    case secondStep
    
    // Retrieve Password Third Step:
    case thirdStepOfRetrievePassword
    case passwordRepeat
    case unmatchedPasswords
    
    // Register First Step:
    case register
    case firstStepOfRegister
    case alreadyRegistered
    
    // Register Second Step:
    case secondStepOfRegister
    case cancelRegisterAndLogin
    
    // Register Third Step:
    case userAgreement
    case privacyPolicy
    
    case thirdStepOfRegister
    case firstName
    case lastName
    case optionalEmail
    case invalidEmail
    case iHaveReadAndAcceptUserAgreementAndPrivacyPolicy
    
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
    
    // Filter Results:
    case search
    
    // Filter:
    case filter
    case unlocked
    case locked
    
    // Product:
    case description
    case productDetails
    
    // Container:
    case viewMore
    case viewLess
    case hottestOffers
    
    // Cart:
    case cart
    case numberOfProducts
    case youWillEarnXPointsFromThisPurchase
    case totalPrice
    case pricesAreTaxInclusive
    case iDonateAllPurchasedProductsToCharity
    case selectOneOfYourAddresses
    case editAddress
    case pay
    case finalizeYourPurchase
    
    // Finalize:
    case purchaseFinalization
    
    // Awards:
    case awards
    case shoppingCenterName
    case pointsAmount
    case percentageAmount
    
    case welcomeToXShoppingCenter
    case tapCheckInToClaimXLoyaltyPoints
    case checkIn
    case yourPointsSuccessfullyUpdated
    case youEarnedPointsFromThisShoppingCenterForToday
    case takeYourTodaysInvoicesToXShoppingCenterCounter
    case claimPoints
    
    // Claim Points:
    case pleaseHaveAllYourTodaysInvoicesStampedBySalesman
    case purchaseAmountInTomans
    case employeeId
    case invalidEmployeeId
    case secretToken
    case submit
    case wrongEmployeeId
    case wrongToken
    
    // Orders:
    case orders
    case orderNumber
    case orderStatus
    case transactionNumber
    case paymentDate
    case hour
    case address
    case donatedToCharity
    case orderDetails
    
    // Profile:
    case profile
    case hello
    case userLevelAndPoints
    case inviteYourFriendsAndEarnPoints
    case logout
    case settings
    case language
    case persian
    case english
    case profileSettings
    case general
    case howItWorks
    case aboutUs
    case contactUs
    case support
    case welcome
    case or
    
    // Favorites:
    case favorites
    case removeAll
    case addAllToCart
}
