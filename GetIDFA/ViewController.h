//
//  ViewController.h
//  GetIDFA
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface ViewController : UIViewController<MFMailComposeViewControllerDelegate>
- (IBAction)sendEmail:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *text;

@end
