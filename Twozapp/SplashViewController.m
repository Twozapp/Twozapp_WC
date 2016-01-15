//
//  SplashViewController.m
//  Twozapp
//
//  Created by Priya on 13/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "SplashViewController.h"
#import "Reachability.h"
#import "SlideAlertiOS7.h"
#import "MBProgressHUD.h"
#import "OnDeck.h"
#import "AppDelegate.h"
#import "NetworkManager.h"

@interface SplashViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *hudProgress;
}

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_activityIndicator startAnimating];
    [self performSelector:@selector(actionStop) withObject:nil afterDelay:1.0];
    
   
    // Do any additional setup after loading the view.
}

- (void)actionStop{
    [_activityIndicator stopAnimating];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"email"] isEqualToString:@""] && [[[NSUserDefaults standardUserDefaults] objectForKey:@"fb_id"] isEqualToString:@""]) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"ConnectFacebookViewController"];
        [self presentViewController:profileTwo animated:YES completion:nil];
    }
    else{
        
        
        {
            Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
            NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
            if (networkStatus == NotReachable) {
                [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"No Internet connection Available."];
            } else {
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                hudProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hudProgress.delegate = self;
                
                hudProgress.mode = MBProgressHUDModeIndeterminate;
                hudProgress.labelText = @"Loading";
                hudProgress.dimBackground = YES;
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                
                NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/login.php?fb_id=%@&email=%@&password=&latitude=%f&logitude=%f",[defaults stringForKey:@"fb_id"], [defaults stringForKey:@"email"],[self appDelegate].location.coordinate.latitude, [self appDelegate].location.coordinate.longitude];
                
                [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                             completionHandler:^(NSError *error, NSDictionary *result) {
                                                                 if(error) {
                                                                     NSLog(@"error : %@", [error description]);
                                                                 } else {
                                                                     // This is the expected result
                                                                     NSLog(@"result : %@", result);
                                                                     if (result.count >0) {
                                                                         if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                             
                                                                             [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Success" withText:@"Successfully changed the password"];
                                                                             
                                                                             //                                                                         UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                             //                                                                         UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                             //                                                                         [self presentViewController:profileTwo animated:YES completion:nil];
                                                                             
                                                                         }
                                                                         else
                                                                         {
                                                                             [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Already registered"];
                                                                             
                                                                             //                                                                         UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                             //                                                                         UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                             //                                                                         [self presentViewController:profileTwo animated:YES completion:nil];
                                                                         }
                                                                     }
                                                                     
                                                                 }
                                                                 UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                 UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                 [self presentViewController:profileTwo animated:YES completion:nil];
                                                                 [self hudWasHidden:hudProgress];
                                                             }];
            }
            
        }
        
//        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
//        [self presentViewController:profileTwo animated:YES completion:nil];
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [hudProgress removeFromSuperview];
    hudProgress = nil;
}
@end
