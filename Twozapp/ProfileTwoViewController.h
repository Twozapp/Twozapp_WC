//
//  ProfileTwoViewController.h
//  Twozapp
//
//  Created by Priya on 11/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnDeck.h"

@interface ProfileTwoViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UITextViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewPRofileTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imgView1;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UITextView *txtViewTellus;
@property (weak, nonatomic) IBOutlet UITextField *txtFldKeyword;
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionViewKeyword;
@property (nonatomic , strong) NSMutableArray *keys;
- (IBAction)actionSave:(id)sender;
- (IBAction)actionAddPhoto1:(id)sender;
- (IBAction)actionPhoto2:(id)sender;

- (IBAction)actionAddPhoto2:(id)sender;
@end
