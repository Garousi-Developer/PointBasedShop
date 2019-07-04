func texts(_ text: Text) -> LocalizedText {
    switch text {
    // Global:
    case .all:
        return LocalizedText(
            persian: "همه",
            english: "All"
        )
    case .back:
        return LocalizedText(
            persian: "بازگشت",
            english: "Back"
        )
    case .singleCount:
        return LocalizedText(
            persian: "عدد",
            english: "Number"
        )
    case .count:
        return LocalizedText(
            persian: "عدد",
            english: "Numbers"
        )
    case .currency:
        return LocalizedText(
            persian: "تومان",
            english: "Toman"
        )
    case .empty:
        return LocalizedText(
            persian: "",
            english: ""
        )
    case .internalServerError:
        return LocalizedText(
            persian: "خطا در سرور",
            english: "Server Error"
        )
    case .more:
        return LocalizedText(
            persian: "بیشتر",
            english: "More"
        )
    case .number:
        return LocalizedText(
            persian: "تا",
            english: ""
        )
    case .points:
        return LocalizedText(
            persian: "امتیاز",
            english: "Points"
        )
    
    // Login:
    case .login:
        return LocalizedText(
            persian: "ورود",
            english: "Login"
        )
    case .mobileNumber:
        return LocalizedText(
            persian: "شماره موبایل",
            english: "Mobile Number"
        )
    case .invalidMobileNumber:
        return LocalizedText(
            persian: "شماره موبایل معتبر نیست",
            english: "Mobile number is not valid"
        )
    case .password:
        return LocalizedText(
            persian: "رمز عبور",
            english: "Password"
        )
    case .shortPassword:
        return LocalizedText(
            persian: "رمز عبور باید حداقل ۴ کاراکتر باشد",
            english: "Password must be at least 4 characters"
        )
    case .unregisteredMobileNumber:
        return LocalizedText(
            persian: "این شماره هنوز ثبت نام نکرده است",
            english: "This number have not registered yet"
        )
    case .inactiveAccount:
        return LocalizedText(
            persian: "این حساب کاربری هنوز فعال نشده است",
            english: "This account have not activated yet"
        )
    case .wrongCredentials:
        return LocalizedText(
            persian: "شماره موبایل یا رمز عبور اشتباه است",
            english: "Mobile number or password is incorrect"
        )
    case .loginWithoutRegister:
        return LocalizedText(
            persian: "ورود بدون عضویت",
            english: "Login Without Register"
        )
        
    // Retrieve Password First Step:
    case .retrievePassword:
        return LocalizedText(
            persian: "بازیابی رمز عبور",
            english: "Retrieve Password"
        )
    case .firstStepOfRetrievePassword:
        return LocalizedText(
            persian: "مرحله اول بازیابی رمز",
            english: "Retrieval First Step"
        )
    case .nextStep:
        return LocalizedText(
            persian: "مرحله بعد",
            english: "Next Step"
        )
    case .wrongVerificationCode:
        return LocalizedText(
            persian: "کد تایید اشتباه است",
            english: "Verification code is incorrect"
        )
    case .firstStep:
        return LocalizedText(
            persian: "مرحله اول",
            english: "First Step"
        )
    case .retrieveCode:
        return LocalizedText(
            persian: "بازیابی رمز",
            english: "Retrieve Password"
        )
    
    // Retrieve Password Second Step:
    case .secondStepOfRetrievePassword:
        return LocalizedText(
            persian: "مرحله دوم بازیابی رمز",
            english: "Retrieval Second Step"
        )
    case .verificationCode:
        return LocalizedText(
            persian: "کد تایید",
            english: "Verification Code"
        )
    case .invalidVerificationCode:
        return LocalizedText(
            persian: "کد تایید باید ۵ رقم باشد",
            english: "Verification code must be 5 digits"
        )
    case .cancelRetrieveCodeAndLogin:
        return LocalizedText(
            persian: "لغو بازیابی رمز و ورود",
            english: "Cancel Retrieval and Login"
        )
    case .secondStep:
        return LocalizedText(
            persian: "مرحله دوم",
            english: "Second Step"
        )
        
    // Retrieve Password Third Step:
    case .thirdStepOfRetrievePassword:
        return LocalizedText(
            persian: "مرحله سوم بازیابی رمز",
            english: "Retrieval Third Step"
        )
    case .passwordRepeat:
        return LocalizedText(
            persian: "تکرار رمز عبور",
            english: "Password Repeat"
        )
    case .unmatchedPasswords:
        return LocalizedText(
            persian: "رمز عبور و تکرار آن با هم مطابقت ندارند",
            english: "Passwords do not match"
        )
        
    //  Register First Step:
    case .register:
        return LocalizedText(
            persian: "عضویت",
            english: "Register"
        )
    case .firstStepOfRegister:
        return LocalizedText(
            persian: "مرحله اول عضویت",
            english: "Register First Step"
        )
    case .alreadyRegistered:
        return LocalizedText(
            persian: "این شماره قبلا ثبت نام کرده است",
            english: "This number has already registered"
        )
        
    //  Register Second Step:
    case .secondStepOfRegister:
        return LocalizedText(
            persian: "مرحله دوم عضویت",
            english: "Register Second Step"
        )
    case .cancelRegisterAndLogin:
        return LocalizedText(
            persian: "لغو عضویت و ورود",
            english: "Cancel Register and Login"
        )
        
    //  Register Third Step:
    case .userAgreement:
        return LocalizedText(
            persian: "توافق نامه کاربری",
            english: "User Agreement"
        )
    case .privacyPolicy:
        return LocalizedText(
            persian: "سیاست حفظ حریم خصوصی",
            english: "Privacy Policy"
        )
        
    case .thirdStepOfRegister:
        return LocalizedText(
            persian: "مرحله سوم عضویت",
            english: "Register Third Step"
        )
    case .firstName:
        return LocalizedText(
            persian: "نام",
            english: "First Name"
        )
    case .lastName:
        return LocalizedText(
            persian: "نام خانوادگی",
            english: "Last Name"
        )
    case .optionalEmail:
        return LocalizedText(
            persian: "ایمیل (اختیاری)",
            english: "Email (Optional)"
        )
    case .invalidEmail:
        return LocalizedText(
            persian: "ایمیل معتبر نیست",
            english: "Email is not valid"
        )
    case .iHaveReadAndAcceptUserAgreementAndPrivacyPolicy:
        return LocalizedText(
            persian: "\(texts(.userAgreement).persian) و \(texts(.privacyPolicy).persian) را خوانده و قبول دارم",
            english: "I have read and accept \(texts(.userAgreement).english) and \(texts(.privacyPolicy).english)"
        )
    
    // Home:
    case .home:
        return LocalizedText(
            persian: "خانه",
            english: "Home"
        )
    case .categories:
        return LocalizedText(
            persian: "دسته بندی ها",
            english: "Categories"
        )
    case .yourPoints:
        return LocalizedText(
            persian: "امتیاز شما",
            english: "Your Points"
        )
    case .closestOffers:
        return LocalizedText(
            persian: "نزدیک ترین پیشنهادات",
            english: "Closest Offers"
        )
    case .countryWidePostable:
        return LocalizedText(
            persian: "قابل ارسال به سراسر کشور",
            english: "Country Wide Postable"
        )
    case .addToCart:
        return LocalizedText(
            persian: "افزودن به سبد خرید",
            english: "Add to Cart"
        )
    case .addMore:
        return LocalizedText(
            persian: "افزودن",
            english: "Add"
        )
    case .sold:
        return LocalizedText(
            persian: "فروخته شده",
            english: "sold"
        )
    case .outOf:
        return LocalizedText(
            persian: "از",
            english: "out of"
        )
    case .cities:
        return LocalizedText(
            persian: "شهرها",
            english: "Cities"
        )
    case .topShoppingCenters:
        return LocalizedText(
            persian: "برترین مراکز خرید",
            english: "Top Shopping Centers"
        )
    case .topBrands:
        return LocalizedText(
            persian: "برترین برندها",
            english: "Top Brands"
        )
    
    // Filter Results:
    case .search:
        return LocalizedText(
            persian: "جستجو",
            english: "Search"
        )
    case .noProductFound:
        return LocalizedText(
            persian: "محصولی پیدا نشد",
            english: "No product found"
        )
    
    // Filter:
    case .filter:
        return LocalizedText(
            persian: "فیلتر",
            english: "Filter"
        )
    case .unlocked:
        return LocalizedText(
            persian: "باز",
            english: "Unlocked"
        )
    case .locked:
        return LocalizedText(
            persian: "قفل",
            english: "Locked"
        )
    
    // Product:
    case .description:
        return LocalizedText(
            persian: "توضیحات",
            english: "Description"
        )
    case .productDetails:
        return LocalizedText(
            persian: "جزئیات محصول",
            english: "Product Details"
        )
    
    // Container:
    case .viewMore:
        return LocalizedText(
            persian: "مشاهده بیشتر",
            english: "View More"
        )
    case .viewLess:
        return LocalizedText(
            persian: "مشاهده کمتر",
            english: "View Less"
        )
    case .hottestOffers:
        return LocalizedText(
            persian: "داغ ترین پیشنهادات",
            english: "Hottest Offers"
        )
    
    // Map:
    case .location:
        return LocalizedText(
            persian: "موقعیت",
            english: "Location"
        )
    
    // Cart:
    case .cart:
        return LocalizedText(
            persian: "سبد خرید",
            english: "Cart"
        )
    case .numberOfProducts:
        return LocalizedText(
            persian: "تعداد محصولات",
            english: "Number of Products"
        )
    case .youWillEarnXPointsFromThisPurchase:
        return LocalizedText(
            persian: "شما از این خرید \(texts(.pointsAmount).persian) امتیاز به دست می آورید",
            english: "You will earn \(texts(.pointsAmount).english) points from this purchase"
        )
    case .totalPrice:
        return LocalizedText(
            persian: "قیمت کل",
            english: "Total Price"
        )
    case .pricesAreTaxInclusive:
        return LocalizedText(
            persian: "قیمت ها با احتساب مالیات هستند",
            english: "Prices are tax inclusive"
        )
    case .iDonateAllPurchasedProductsToCharity:
        return LocalizedText(
            persian: "همه محصولات خریداری شده را به خیریه اهدا می کنم",
            english: "I donate all purchased products to charity"
        )
    case .selectOneOfYourAddresses:
        return LocalizedText(
            persian: "یکی از آدرس های خود را انتخاب کنید",
            english: "Choose one of your addresses"
        )
    case .editAddress:
        return LocalizedText(
            persian: "ویرایش آدرس",
            english: "Edit Address"
        )
    case .pay:
        return LocalizedText(
            persian: "پرداخت",
            english: "Pay"
        )
    case .finalizeYourPurchase:
        return LocalizedText(
            persian: "خرید خود را نهایی کنید",
            english: "Finalize your purchase"
        )
    case .yourCartIsEmpty:
        return LocalizedText(
            persian: "سبد خرید شما خالی است",
            english: "Your cart is empty"
        )
    
    // Finalize:
    case .purchaseFinalization:
        return LocalizedText(
            persian: "نهایی کردن خرید",
            english: "Purchase Finalization"
        )
    
    // Awards:
    case .awards:
        return LocalizedText(
            persian: "جوایز",
            english: "Awards"
        )
    case .shoppingCenterName:
        return LocalizedText(
            persian: "نام مرکز خرید",
            english: "Shopping Center Name"
        )
    case .pointsAmount:
        return LocalizedText(
            persian: "مقدار امتیاز",
            english: "Points Amount"
        )
    case .percentageAmount:
        return LocalizedText(
            persian: "مقدار درصد",
            english: "Percentage Amount"
        )
    
    case .welcomeToXShoppingCenter:
        return LocalizedText(
            persian: "به مرکز خرید \(texts(.shoppingCenterName).persian) خوش آمدید",
            english: "Welcome to \(texts(.shoppingCenterName).english) shopping center"
        )
    case .tapCheckInToClaimXLoyaltyPoints:
        return LocalizedText(
            persian: "برای کسب \(texts(.pointsAmount).persian) امتیاز وفاداری دکمه ثبت حضور را بزنید",
            english: "Tap Check In to claim \(texts(.pointsAmount).english) loyalty points"
        )
    case .checkIn:
        return LocalizedText(
            persian: "ثبت حضور",
            english: "Check In"
        )
    case .yourPointsSuccessfullyUpdated:
        return LocalizedText(
            persian: "امتیاز شما با موفقیت به روز رسانی شد",
            english: "Your points successfully updated"
        )
    case .youEarnedPointsFromThisShoppingCenterForToday:
        return LocalizedText(
            persian: "شما امروز از این فروشگاه امتیاز دریافت کرده اید",
            english: "You earned points from this shopping center for today"
        )
    case .takeYourTodaysInvoicesToXShoppingCenterCounter:
        return LocalizedText(
            persian: """
            فاکتورهای امروز خود را به پیشخوان مرکز خرید \(texts(.shoppingCenterName).persian) ببرید
            و با توجه به کل مبلغ خرید خود امتیاز کسب کنید
            """,
            english: """
            Take your today's invoices to \(texts(.shoppingCenterName).english) shopping center counter
            and earn points according to your total purchase amount
            """
        )
    case .claimPoints:
        return LocalizedText(
            persian: "کسب امتیاز",
            english: "Claim Points"
        )
        
    // Claim Points:
    case .pleaseHaveAllYourTodaysInvoicesStampedBySalesman:
        return LocalizedText(
            persian: "لطفا همه فاکتورهای امروز خود را توسط فروشنده مهر کنید و اجازه دهید مبلغ خرید و کد خود را وارد کند تا امتیازتان را کسب کنید",
            english: "Please have all your todays invoice's stamped by salesman and let him enter purchase amount and his code to earn your points"
        )
    case .purchaseAmountInTomans:
        return LocalizedText(
            persian: "مبلغ خرید به تومان",
            english: "Purchase Amount in Toman"
        )
    case .employeeId:
        return LocalizedText(
            persian: "شناسه کارمند",
            english: "Employee Id"
        )
    case .invalidEmployeeId:
        return LocalizedText(
            persian: "شناسه کارمند باید ۴ رقم باشد",
            english: "Employee id must be 4 digits"
        )
    case .secretToken:
        return LocalizedText(
            persian: "کد محرمانه",
            english: "Secret Token"
        )
    case .submit:
        return LocalizedText(
            persian: "تایید",
            english: "Submit"
        )
    case .wrongEmployeeId:
        return LocalizedText(
            persian: "شناسه کارمند اشتباه است",
            english: "Employee id is incorrect"
        )
    case .wrongToken:
        return LocalizedText(
            persian: "کد محرمانه اشتباه است یا منقضی شده است",
            english: "Secret token is incorrect or expired"
        )
    
    // Orders:
    case .orders:
        return LocalizedText(
            persian: "سفارشات",
            english: "Orders"
        )
    case .orderNumber:
        return LocalizedText(
            persian: "شماره سفارش",
            english: "Order Number"
        )
    case .orderStatus:
        return LocalizedText(
            persian: "وضعیت سفارش",
            english: "Order Status"
        )
    case .transactionNumber:
        return LocalizedText(
            persian: "شماره تراکنش",
            english: "Transaction Number"
        )
    case .paymentDate:
        return LocalizedText(
            persian: "تاریخ پرداخت",
            english: "Payment Date"
        )
    case .hour:
        return LocalizedText(
            persian: "ساعت",
            english: "at"
        )
    case .address:
        return LocalizedText(
            persian: "آدرس",
            english: "Address"
        )
    case .donatedToCharity:
        return LocalizedText(
            persian: "اهدا شده به خیریه",
            english: "Donated to Charity"
        )
    case .orderDetails:
        return LocalizedText(
            persian: "جزئیات سفارش",
            english: "Order Details"
        )
    case .youHaveNoOrdersYet:
        return LocalizedText(
            persian: "شما هنوز سفارشی ثبت نکرده اید",
            english: "You have not registered an order yet"
        )
    
    // Profile:
    case .profile:
        return LocalizedText(
            persian: "پروفایل",
            english: "Profile"
        )
    case .hello:
        return LocalizedText(
            persian: "سلام",
            english: "Hello"
        )
    case .userLevelAndPoints:
        return LocalizedText(
            persian: "سطح کاربری و امتیاز",
            english: "User Level and Points"
        )
    case .bronzeUser:
        return LocalizedText(
            persian: "کاربر برنزی",
            english: "Bronze User"
        )
    case .silverUser:
        return LocalizedText(
            persian: "کاربر نقره ای",
            english: "Silver User"
        )
    case .goldenUser:
        return LocalizedText(
            persian: "کاربر طلایی",
            english: "Golden User"
        )
    case .inviteYourFriendsAndEarnPoints:
        return LocalizedText(
            persian: "دوستان خود را دعوت کنید و امتیاز بگیرید",
            english: "Invite your friends and earn points"
        )
    case .logout:
        return LocalizedText(
            persian: "خروج",
            english: "Logout"
        )
    case .signedInAs:
        return LocalizedText(
            persian: "وارد شده به عنوان",
            english: "Signed in as"
        )
    case .settings:
        return LocalizedText(
            persian: "تنظیمات",
            english: "Settings"
        )
    case .language:
        return LocalizedText(
            persian: "زبان",
            english: "Language"
        )
    case .persian:
        return LocalizedText(
            persian: "فارسی",
            english: "فارسی"
        )
    case .english:
        return LocalizedText(
            persian: "English",
            english: "English"
        )
    case .general:
        return LocalizedText(
            persian: "عمومی",
            english: "General"
        )
    case .howItWorks:
        return LocalizedText(
            persian: "چطور کار می کند",
            english: "How it Works"
        )
    case .aboutUs:
        return LocalizedText(
            persian: "درباره ما",
            english: "About Us"
        )
    case .contactUs:
        return LocalizedText(
            persian: "ارتباط با ما",
            english: "Contact Us"
        )
    case .support:
        return LocalizedText(
            persian: "پشتیبانی",
            english: "Support"
        )
    case .share:
        return LocalizedText(
            persian: "اشتراک گذاری",
            english: "Share"
        )
    case .shareText:
        return LocalizedText(
            persian: "متن آزمایشی",
            english: "Test Text"
        )
    case .welcome:
        return LocalizedText(
            persian: "خوش آمدید",
            english: "Welcome"
        )
    case .or:
        return LocalizedText(
            persian: "یا",
            english: "or"
        )
    
    // Favorites:
    case .favorites:
        return LocalizedText(
            persian: "علاقه مندی ها",
            english: "Favorites"
        )
    case .removeAll:
        return LocalizedText(
            persian: "حذف همه",
            english: "Remove All"
        )
    case .addAllToCart:
        return LocalizedText(
            persian: "افزودن همه به سبد خرید",
            english: "Add All to Cart"
        )
    case .noItemHasBeenAddedToFavoritesYet:
        return LocalizedText(
            persian: "هنوز موردی به علاقه مندی ها افزوده نشده است",
            english: "No item has been added to favorites yet"
        )
    
    // Profile Settings:
    case .profileSettings:
        return LocalizedText(
            persian: "اطلاعات شخصی",
            english: "Personal Information"
        )
    case .account:
        return LocalizedText(
            persian: "حساب کاربری",
            english: "Account"
        )
    case .email:
        return LocalizedText(
            persian: "ایمیل",
            english: "Email"
        )
    case .verify:
        return LocalizedText(
            persian: "تایید",
            english: "Verify"
        )
    case .saveChanges:
        return LocalizedText(
            persian: "ذخیره تغییرات",
            english: "Save Changes"
        )
    case .addAndEditAddress:
        return LocalizedText(
            persian: "افزودن و ویرایش آدرس",
            english: "Add and Edit Address"
        )
    case .addAddress:
        return LocalizedText(
            persian: "افزودن آدرس",
            english: "Add Address"
        )
    
    // Invite:
    case .friendsInvitation:
        return LocalizedText(
            persian: "دعوت از دوستان",
            english: "Friends Invitation"
        )
    case .invite:
        return LocalizedText(
            persian: "دعوت",
            english: "Invite"
        )
    case .yourInvitationSentSuccessfully:
        return LocalizedText(
            persian: "دعوت نامه شما با موفقیت ارسال شد",
            english: "Your invitation sent successfully"
        )
    case .thisNumberHasAlreadyBeenInvited:
        return LocalizedText(
            persian: "این شماره قبلا دعوت شده است",
            english: "This number has already been invited"
        )
    case .thisNumberHasAlreadyRegistered:
        return LocalizedText(
            persian: "این شماره قبلا ثبت نام کرده است",
            english: "This number has already registered"
        )
    }
}
enum Text: String {
    // Global:
    case all
    case back
    case singleCount
    case count
    case currency
    case empty
    case internalServerError
    case more
    case number
    case points
    
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
    case noProductFound
    
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
    
    // Map:
    case location
    
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
    case yourCartIsEmpty
    
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
    case youHaveNoOrdersYet
    
    // Profile:
    case profile
    case hello
    case userLevelAndPoints
    case bronzeUser
    case silverUser
    case goldenUser
    case inviteYourFriendsAndEarnPoints
    case logout
    case signedInAs
    case settings
    case language
    case persian
    case english
    case general
    case howItWorks
    case aboutUs
    case contactUs
    case support
    case share
    case shareText
    case welcome
    case or
    
    // Favorites:
    case favorites
    case removeAll
    case addAllToCart
    case noItemHasBeenAddedToFavoritesYet
    
    // Profile Settings:
    case profileSettings
    case account
    case email
    case verify
    case saveChanges
    case addAndEditAddress
    case addAddress
    
    // Invite:
    case friendsInvitation
    case invite
    case yourInvitationSentSuccessfully
    case thisNumberHasAlreadyBeenInvited
    case thisNumberHasAlreadyRegistered
}

struct LocalizedText {
    let persian: String
    let english: String
}
