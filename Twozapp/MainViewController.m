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
    _imgViewProfilePic.layer.cornerRadius = 5.0f;
    [_imgViewProfilePic.layer setMasksToBounds:YES];
    _viewName.layer.cornerRadius = 5.0f;
    [_viewName.layer setMasksToBounds:YES];
    _viewBazi.layer.cornerRadius = 5.0f;
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
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"imgSample.png"],
                        [UIImage imageNamed:@"imgSample.png"]];
    NSArray *colors = @[[UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1]];
    
    // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName;
    NSArray *labels;
    if (userName.length >0) {
        labels  = @[@"", @"", @"My Trips", @"Fare Chart", @"About Us", @"Feedback", @"Rate Us"];
    }
    else{
        
        labels = @[@"Me",@"", @"My Trips", @"Fare Chart", @"About Us", @"Feedback", @"Rate Us"];
    }
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors textLabels:labels];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];

}
@end
