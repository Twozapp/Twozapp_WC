//
//  ConnectFacebookViewController.m
//  Twozapp
//
//  Created by Priya on 09/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ConnectFacebookViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "Reachability.h"
#import "NetworkManager.h"
#import "SlideAlertiOS7.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "UserDetails.h"


@interface ConnectFacebookViewController ()<MBProgressHUDDelegate>{
    MBProgressHUD *hudProgress;
}
@end


@implementation ConnectFacebookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _viewFacebook.layer.cornerRadius = 5.0f;
    [_viewFacebook.layer setMasksToBounds:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionFacebook:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions: @[@"public_profile",@"user_friends",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             NSLog(@"Result %@",result);
             
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                           initWithGraphPath:@"/me"
                                           parameters:@{ @"fields": @"id,name,email"}
                                           HTTPMethod:@"GET"];
             [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                 
                 NSLog(@"resds %@",result);
                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                 [defaults setObject:[result valueForKey:@"email"] forKey:@"email"];
                 [defaults setObject:[result valueForKey:@"id"] forKey:@"fb_id"];
                 [defaults synchronize];
                 
                 Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
                 NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
                 if (networkStatus == NotReachable) {
                     [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"No Internet connection Available."];
                     [self performSegueWithIdentifier:@"tofacebook" sender:nil];
                 } else {
                     
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                   
                     
                     NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/login.php?fb_id=%@&email=%@&password=&latitude=%f&logitude=%f",[defaults stringForKey:@"fb_id"], [defaults stringForKey:@"email"],[self appDelegate].location.coordinate.latitude, [self appDelegate].location.coordinate.longitude];
                     
                     [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                                  completionHandler:^(NSError *error, NSDictionary *result) {
                                                                      if(error) {
                                                                          [self performSegueWithIdentifier:@"tofacebook" sender:nil];
                                                                          NSLog(@"error : %@", [error description]);
                                                                      } else {
                                                                        
                                                                          NSLog(@"Facebook login result : %@", result);
                                                                          if (result.count >0) {
                                                                              if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                                  
                                                                                  if (result[@"response"][@"User Profile"] != nil) {
                                                                                      [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Successfully Logged in"];
                                                                                      
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
                                                                                      UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"ContentViewControllerNavi"];
                                                                                      [self presentViewController:profileTwo animated:YES completion:nil];
                                                                                      
                                                                                  }
                                                                                  
  
                                                                              }
                                                                              else
                                                                              {
                                                                                  
                                                                                  UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                                                                                  UIViewController *profileOne = [story instantiateViewControllerWithIdentifier:@"ProfileOneViewControllerNavi"];
                                                                                  [self presentViewController:profileOne animated:YES completion:nil];
                                                                                 
                                                                              }
                                                                          }
                                                                          else
                                                                          {
                                                                              
                                                                              [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Error in connectivity. Please try again."];
                                                                          }
                                                                          
                                                                      }
                                                                      
                                                                      [self hudWasHidden:hudProgress];
                                                                  }];
                 }

                 
                 
             }];
         }
     }];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{ @"fields": @"id,name,email"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        NSLog(@"resds %@",result);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[result valueForKey:@"email"] forKey:@"email"];
        [defaults setObject:[result valueForKey:@"id"] forKey:@"fb_id"];
        [defaults synchronize];
    }];
}

#pragma mark - Smart Function

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    // Remove HUD from screen when the HUD was hidded
    [hudProgress removeFromSuperview];
    hudProgress = nil;
}

@end
