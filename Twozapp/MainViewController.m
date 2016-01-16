//
//  MainViewController.m
//  Twozapp
//
//  Created by Priya on 10/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "MainViewController.h"
#import "RNFrostedSidebar.h"

@interface MainViewController ()<RNFrostedSidebarDelegate>
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imgViewProfilePic.layer.cornerRadius = 7.0f;
    [_imgViewProfilePic.layer setMasksToBounds:YES];
    _viewName.layer.cornerRadius = 7.0f;
    [_viewName.layer setMasksToBounds:YES];
    _viewBazi.layer.cornerRadius = 7.0f;
    [_viewBazi.layer setMasksToBounds:YES];
    
    UIImage *navImage =  [[UIImage imageNamed:@"navigationbar"]
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsCompact];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionSideMenu:(id)sender {
    
    NSArray *images = @[
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"chat"],
                        [UIImage imageNamed:@"match1"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"]];
    NSArray *colors = @[[UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]
                        ];
    
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName;
    NSArray *labels;
    if (userName.length >0) {
      //  labels  = @[@"", @"", @"My Trips", @"Fare Chart", @"About Us", @"Feedback", @"Rate Us"];
    }
    else{
        
        labels = @[@"Priyanka",@"Chats", @"Matches", @"Profile", @"My Bazi"];
    }
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors textLabels:labels];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];

}

- (IBAction)actionNotIntrested:(id)sender {
    _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.3/2 animations:^{
        _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            _btnNotIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _btnNotIntrested.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
 
    
}

- (IBAction)actionIntrested:(id)sender {
    
    _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [UIView animateWithDuration:0.3/2 animations:^{
        _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            _btnIntrested.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                _btnIntrested.transform = CGAffineTransformIdentity;
            }];
        }];
    }];

}
@end
