//
//  ContentViewController.m
//  Twozapp
//
//  Created by Dipin on 21/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ContentViewController.h"
#import "MatchesViewController.h"
#import "MainViewController.h"
#import "ProfileOneViewController.h"
#import "UserDetails.h"
#import "ChatListViewController.h"

@interface ContentViewController ()
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;


@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MainViewController *main = [story instantiateViewControllerWithIdentifier:@"MainViewController"];
    
    [self addChildViewController:main];
    [self.view addSubview:main.view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionMenu:(id)sender {
    
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
    
    NSArray *labels = @[[UserDetails sharedInstance].full_name,@"Chats", @"Matches", @"Profile", @"My Bazi"];
    
    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors textLabels:labels];
    //    RNFrostedSidebar *callout = [[RNFrostedSidebar alloc] initWithImages:images];
    callout.delegate = self;
    //    callout.showFromRight = YES;
    [callout show];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
    if (index == 0) {
        [sidebar dismissAnimated:YES completion:nil];
        
        for (UIView *view  in self.view.subviews) {
            [view removeFromSuperview];
        }
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MainViewController *main = [story instantiateViewControllerWithIdentifier:@"MainViewController"];
        
        [self addChildViewController:main];
        [self.view addSubview:main.view];
        
    }
    if (index == 1) {
        [sidebar dismissAnimated:YES completion:nil];
        
        for (UIView *view  in self.view.subviews) {
            [view removeFromSuperview];
        }
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ChatListViewController *chats = [story instantiateViewControllerWithIdentifier:@"ChatListViewController"];
        [self addChildViewController:chats];
        [self.view addSubview:chats.view];
        
    }
    
    if (index == 2){
        [sidebar dismissAnimated:YES completion:^{
            
        }];

        for (UIView *view  in self.view.subviews) {
            [view removeFromSuperview];
        }
        
        
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MatchesViewController *matches = [story instantiateViewControllerWithIdentifier:@"MatchesViewController"];
        [self addChildViewController:matches];
        [self.view addSubview:matches.view];
        
    }
    if (index == 3) {
        [sidebar dismissAnimated:YES completion:nil];
        
        for (UIView *view  in self.view.subviews) {
            [view removeFromSuperview];
        }
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *gsvc = [storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
        
        [self addChildViewController:gsvc];
        [self.view addSubview:gsvc.view];
        
    }
    if (index == 4) {
        [sidebar dismissAnimated:YES completion:nil];
        
    }
    
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}
@end
