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


@interface ConnectFacebookViewController ()

@end

@implementation ConnectFacebookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewFacebook.layer.cornerRadius = 5.0f;
    [_viewFacebook.layer setMasksToBounds:YES];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)actionFacebook:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"user_friends",@"email"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             NSLog(@"Result %@",result);
            // NSLog(@"email = %@",[result valueForKey:@"email"]);
             UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
             UIViewController *profileOne = [story instantiateViewControllerWithIdentifier:@"ProfileOneViewControllerNavi"];
             [self presentViewController:profileOne animated:YES completion:nil];
             
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
@end
