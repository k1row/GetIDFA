//
//  ViewController.m
//  GetIDFA
//
//

#import "ViewController.h"
#import <AdSupport/ASIdentifierManager.h>


@interface ViewController ()

@end

@implementation ViewController

- (NSString *) advertisingIdentifier
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

- (NSString *) identifierForVendor
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(identifierForVendor)])
    {
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return @"";
}

- (BOOL)isAdvertisingTrackingEnabled
{
    if (NSClassFromString(@"ASIdentifierManager") &&
        (![[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]))
    {
        return NO;
    }
    return YES;
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog (@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog (@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog (@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog (@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    if (![self isAdvertisingTrackingEnabled])
    {

      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Limit Ad Tracking"
                          message:@"Your AdvertisingTracking setting is Limit Ad Tracking."
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
      [alert show];
    }

    _text.text = [self advertisingIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender
{
    // Email Subject
    NSString *emailSubject = @"GetIDFA";
    
    // Email Content
    NSString *emailBody = _text.text;
    
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@""];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailSubject];
    [mc setMessageBody:emailBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];    
}
@end
