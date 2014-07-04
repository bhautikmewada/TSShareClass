//
//  TSShareClass.h
//  MyExample
//
//  Created by Romit Mewada on 7/3/14.
//  Copyright (c) 2014 IDeAL Experiential Learning ℗ Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

typedef enum
{
    Facebook,
    Twitter,
    Mail,
    
}share;

@interface TSShareClass : NSObject<MFMailComposeViewControllerDelegate,UIDocumentInteractionControllerDelegate>

//pass url of app for Sharing
@property(nonatomic,strong)NSString *urlString;

//pass app image for sharing
@property(nonatomic,strong)NSString *imageName;

//pass appName for sharing
@property(nonatomic,strong)NSString *appName;

//pass rateURL for sharing
@property(nonatomic,strong)NSString *rateURL;

//pass messageBody for mail
@property(nonatomic,strong)NSString *messageBody;

/** Singalton object */
+(instancetype)shareInstance;

/** Share to Facebook,Twitter & Mail */
+ (void)shareTo:(share)share;

/** method for share app to More like WhatsApp,Tumbler,FlipBoard*/
+(void)shareToMoreInView:(UIView*)view OpenMenuFromRect:(CGRect)rect;

@end
