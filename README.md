TSShareClass
============

Just Pass Parameters & Call Method For Share to Facebook, Twitter, Mail & More
 
/**pass url of app*/

```@property(nonatomic,strong)NSString *urlString;```

/**pass app image*/

```@property(nonatomic,strong)NSString *imageName;```

/**pass appName*/

```@property(nonatomic,strong)NSString *appName;```

/**pass rateURL*/

```@property(nonatomic,strong)NSString *rateURL;```

/**pass messagebody for mail*/

```@property(nonatomic,strong)NSString *messageBody;```

/**Singleton object*/

+(instancetype)shareInstance;

/**Share to Facebook,Twitter & Mail*/

+ (void)shareTo:(share)share;
 
/**method for share app to More like WhatsApp, Tumbler, FlipBoard*/

+(void)shareToMoreInView:(UIView*)view OpenMenuFromRect:(CGRect)rect;

/**How to use*/
 
 /**Want To Share on Facebook*/
 
    [TSShareClass shareInstance].imageName = @"IMAGE_NAME"; // ImageIcon
    [TSShareClass shareInstance].appName = @"YOUR_APPNAME"; // Your App Name
    [TSShareClass shareInstance].urlString = @"URL_STRING"; // Your App URL String
    [TSShareClass shareTo:Facebook]; // Share To Facebook
 
 /**Want To Share on Twitter*/
 
    [TSShareClass shareInstance].imageName = @"IMAGE_NAME"; // ImageIcon
    [TSShareClass shareInstance].appName = @"YOUR_APPNAME"; // Your App Name
    [TSShareClass shareInstance].urlString = @"URL_STRING"; // Your App URL String
    [TSShareClass shareTo:Twitter]; // Share To Twitter

 /**Want To Share on Mail*/
 
    [TSShareClass shareInstance].imageName = @"IMAGE_NAME"; // ImageIcon
    [TSShareClass shareInstance].appName = @"YOUR_APPNAME"; // Your App Name
    [TSShareClass shareInstance].urlString = @"URL_STRING"; // Your App URL String
    [TSShareClass shareInstance].messageBody = @"MESSAGE_BODY"; // Message Body
    [TSShareClass shareTo:Mail]; // Share To Mail
    
 /**Want To Share on More Like WhatsApp, Tumbler, FlipBoard*/
 
    [TSShareClass shareInstance].imageName = @"IMAGE_NAME"; // ImageIcon
    [TSShareClass shareInstance].appName = @"YOUR_APPNAME"; // Your App Name
    [TSShareClass shareInstance].urlString = @"URL_STRING"; // Your App URL String
    [TSShareClass shareToMoreInView:self.view OpenMenuFromRect:CGRectZero];


