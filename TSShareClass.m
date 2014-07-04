//
//  TSShareClass.m
//  MyExample
//
//  Created by Bhautik Mewada on 7/3/14.
//  Copyright (c) 2014 True Swan Software. All rights reserved.
//

#import "TSShareClass.h"
#import "AppDelegate.h"

static TSShareClass *shareClass;

@implementation TSShareClass
{
    UIDocumentInteractionController *documentController;
}

+(instancetype)shareInstance
{
    if(!shareClass)
    {
        shareClass = [TSShareClass new];
    }
    return shareClass;
}

#pragma mark Share

/** method for share app to Facebook,Twitter,Mail **/
+(void)shareTo:(share)share
{
    
    //SLComposeViewController for Facebook,Twitter sharing
    SLComposeViewController *controller;
    
    //MFMailComposeViewController for send mail
    MFMailComposeViewController *mailer;
    
    if(share == Facebook) //share on Facebook
    {
        controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        //set Text
        [controller setInitialText:[NSString stringWithFormat:@"%@ available on App Store %@",[TSShareClass shareInstance].appName,[TSShareClass shareInstance].rateURL]];
        
        //url of app
        [controller addURL:[NSURL URLWithString:[TSShareClass shareInstance].urlString]];
        
        //app icon of app
        [controller addImage:[UIImage imageNamed:[TSShareClass shareInstance].imageName]];
    }
    else if (share == Twitter) //share on Twitter
    {
        controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        //set Text, RateURL, App Name
        [controller setInitialText:[NSString stringWithFormat:@"%@ available on App Store %@",[TSShareClass shareInstance].appName,[TSShareClass shareInstance].rateURL]];
        
        // pass URLString
        [controller addURL:[NSURL URLWithString:[TSShareClass shareInstance].urlString]];
        
        //pass App Icon
        [controller addImage:[UIImage imageNamed:[TSShareClass shareInstance].imageName]];
    }
    else if (share == Mail) //share via Mail
    {
        if ([MFMailComposeViewController canSendMail])
        {
            mailer = [[MFMailComposeViewController alloc] init];
            mailer.mailComposeDelegate = [TSShareClass shareInstance];
            [mailer setSubject:[NSString stringWithFormat:@"%@ available on App Store.",[TSShareClass shareInstance].appName]];
            
            UIImage *myImage = [UIImage imageNamed:[TSShareClass shareInstance].imageName];
            NSData *imageData = UIImagePNGRepresentation(myImage);
            [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:[TSShareClass shareInstance].imageName];
            
            [mailer setMessageBody:[NSString stringWithFormat:@"%@ available on App Store %@ \n\n GET IT NOW",[TSShareClass shareInstance].appName,[TSShareClass shareInstance].rateURL] isHTML:NO];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                            message:@"Your device doesn't support the composer sheet"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
        }
        
    }
    
    // Create View Controller for present Image picker
    UIViewController *vc = [[(AppDelegate *) [[UIApplication sharedApplication] delegate] window] rootViewController];
    
    if(share == Mail)// if mail
    {
        if ([MFMailComposeViewController canSendMail])
        {
            [vc presentViewController:mailer animated:YES completion:nil];
        }
    }
    else //facebook,twitter
    {
        [vc presentViewController:controller animated:YES completion:nil];
    }
}


/** method for share app to More like WhatsApp,Tumbler,FlipBoard **/
+(void)shareToMoreInView:(UIView*)view OpenMenuFromRect:(CGRect)rect
{
    [[TSShareClass shareInstance] startWhatsAppWithMessage:view OpenMenuFromRect:rect];
}

-(void)startWhatsAppWithMessage:(UIView*)view OpenMenuFromRect:(CGRect)rect
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:[TSShareClass shareInstance].imageName ofType:@""];
    documentController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:filePath]];
    documentController.delegate = self;
    documentController.UTI = @"net.whatsapp.image";
    [documentController presentOpenInMenuFromRect:rect inView:view animated:YES];
}

- (UIDocumentInteractionController *) setupControllerWithURL: (NSURL*) fileURL  usingDelegate: (id <UIDocumentInteractionControllerDelegate>) interactionDelegate
{
    documentController = [UIDocumentInteractionController interactionControllerWithURL: fileURL];
    documentController.delegate = interactionDelegate;
    return documentController;
}

#pragma mark MFMailComposerDelegate

//MFMailComposerController Delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove Mail View
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
