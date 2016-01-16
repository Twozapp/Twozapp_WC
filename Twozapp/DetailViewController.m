//
//  DetailViewController.m
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewBazi.layer.cornerRadius = 7.0;
    [_viewBazi.layer setMasksToBounds:YES];
    _imgviewProfile.layer.cornerRadius = 7.0;
    [_imgviewProfile.layer setMasksToBounds:YES];
    
    _viewName.layer.cornerRadius = 7.0;
    [_viewName.layer setMasksToBounds:YES];
    _viewMatch.layer.cornerRadius = 5.0;
    [_viewMatch.layer setMasksToBounds:YES];
    _viewChat.layer.cornerRadius = 5.0;
    [_viewChat.layer setMasksToBounds:YES];
    
    _imgviewProfile.image = [UIImage imageNamed:@"imgSample.png"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 3.0f;
    [cell.layer setMasksToBounds:YES];
    
    UIButton *btnDelete = (UIButton *)[cell viewWithTag:10];
    [btnDelete.layer setMasksToBounds:YES];
    [btnDelete addTarget:self action:@selector(actionDelete:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
   // lblTitle.text = [keys objectAtIndex:indexPath.item];
    lblTitle.text = @"Fun";
    
    return cell;
}

/*- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSString *key = keys[indexPath.item];
//    UIFont *myFont = [UIFont fontWithName:@"Segoe Print" size:17.0];
//    
//    NSAttributedString *attributedText =
//    [[NSAttributedString alloc] initWithString:key
//                                    attributes:@{NSFontAttributeName: myFont}];
//    CGRect rect = [attributedText boundingRectWithSize:(CGSize){CGFLOAT_MAX, 30}
//                                               options:NSStringDrawingUsesLineFragmentOrigin
//                                               context:nil];
    return 1;
}*/

- (IBAction)actionDelete:(id)sender {
}

- (IBAction)actionChat:(id)sender {
}

- (IBAction)actionMatch:(id)sender {
}
@end
