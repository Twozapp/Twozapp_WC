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
#import "UserDetails.h"

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
    
    //if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"email"] == nil && [[NSUserDefaults standardUserDefaults] objectForKey:@"fb_id"] == nil) {
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
//                hudProgress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//                hudProgress.delegate = self;
//                
//                hudProgress.mode = MBProgressHUDModeIndeterminate;
//                hudProgress.labelText = @"Loading";
//                hudProgress.dimBackground = YES;
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
                                                                           
                                                                             if (result[@"response"][@"User Profile"] != nil) {
                                                                                 [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Success" withText:@"Successfully Logged in"];
                                                                                 
                                                                                 UserDetails *userDetails = [UserDetails sharedInstance];
                                                                                 userDetails.chinese_element = result[@"response"][@"User Profile"][0][@"chinese_element"];
                                                                                 userDetails.date = result[@"response"][@"User Profile"][0][@"date"];
                                                                                 userDetails.day_column_one = result[@"response"][@"User Profile"][0][@"day_column_one"];
                                                                                 userDetails.day_column_two = result[@"response"][@"User Profile"][0][@"day_column_two"];
                                                                                 userDetails.descriptions = result[@"response"][@"User Profile"][0][@"description"];
                                                                                 userDetails.email = result[@"response"][@"User Profile"][0][@"email"];
                                                                                 userDetails.fb_id = result[@"response"][@"User Profile"][0][@"fb_id"];
                                                                                 userDetails.full_name = result[@"response"][@"User Profile"][0][@"full_name"];
                                                                                 userDetails.gender = result[@"response"][@"User Profile"][0][@"gender"];
                                                                                 userDetails.hr_mm_column_one = result[@"response"][@"User Profile"][0][@"hr_mm_column_one"];
                                                                                 userDetails.hr_mm_column_two = result[@"response"][@"User Profile"][0][@"hr_mm_column_two"];
                                                                                 userDetails.user_id = result[@"response"][@"User Profile"][0][@"id"];
                                                                                 userDetails.last_online = result[@"response"][@"User Profile"][0][@"last_online"];
                                                                                 userDetails.latitude = result[@"response"][@"User Profile"][0][@"latitude"];
                                                                                 userDetails.logitude = result[@"response"][@"User Profile"][0][@"logitude"];
                                                                                 userDetails.modified_date = result[@"response"][@"User Profile"][0][@"modified_date"];
                                                                                 userDetails.month_column_one = result[@"response"][@"User Profile"][0][@"month_column_one"];
                                                                                 userDetails.month_column_two = result[@"response"][@"User Profile"][0][@"month_column_two"];
                                                                                 userDetails.password = result[@"response"][@"User Profile"][0][@"password"];
                                                                                 userDetails.status = result[@"response"][@"User Profile"][0][@"status"];
                                                                                 userDetails.year_column_one = result[@"response"][@"User Profile"][0][@"year_column_one"];
                                                                                 userDetails.year_column_two = result[@"response"][@"User Profile"][0][@"year_column_two"];
                                                                                 userDetails.zodiac_animal = result[@"response"][@"User Profile"][0][@"zodiac_animal"];
                                                                               
                                                                                 UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                                 UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                                 [self presentViewController:profileTwo animated:YES completion:nil];
                                                                                 
                                                                             }
                                                                            
                                                                           
                                                                        
                                                                             
                                                                             
                                                                             //                                                                         UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                             //                                                                         UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                             //                                                                         [self presentViewController:profileTwo animated:YES completion:nil];
                                                                             
                                                                         }
                                                                         else
                                                                         {
                                                                            
                                                                             [self performSegueWithIdentifier:@"tofacebook" sender:nil];
                                                                             //                                                                         UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                             //                                                                         UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"MainViewControllerNavi"];
                                                                             //                                                                         [self presentViewController:profileTwo animated:YES completion:nil];
                                                                         }
                                                                     }
                                                                     
                                                                 }
                                                                
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
