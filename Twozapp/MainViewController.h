//
//  MainViewController.h
//  Twozapp
//
//  Created by Priya on 10/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfilePic;
@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UIView *viewBazi;
@property (weak, nonatomic) IBOutlet UILabel *lblName;

- (IBAction)actionSideMenu:(id)sender;

@end
