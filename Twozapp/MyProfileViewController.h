//
//  MyProfileViewController.h
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imagViewMyProfilePic;
@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
- (IBAction)actionEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionViewIntrest;

@end
