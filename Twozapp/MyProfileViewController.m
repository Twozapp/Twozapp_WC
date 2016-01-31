//
//  MyProfileViewController.m
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "MyProfileViewController.h"
#import "UserDetails.h"
#import "NetworkManager.h"
#import "UserDetails.h"

@interface MyProfileViewController ()

@end

@implementation MyProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSelector:@selector(requestIntrestList) withObject:nil afterDelay:0.25];
    
    _imagViewMyProfilePic.layer.cornerRadius = 7.0f;
    [_imagViewMyProfilePic.layer setMasksToBounds:YES];
    
    _viewName.layer.cornerRadius = 7.0f;
    [_viewName.layer setMasksToBounds:YES];
    
    _lblName.text = [NSString stringWithFormat:@"%@",[UserDetails sharedInstance].full_name];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestIntrestList{
    NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/interest_list.php?user_id=%@",[UserDetails sharedInstance].user_id];
    
    [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                 completionHandler:^(NSError *error, NSDictionary *result) {
                                                     if(error) {
                                                         NSLog(@"error : %@", [error description]);
                                                     } else {
                                                         // This is the expected result
                                                         NSLog(@"Intrest result : %@", result);
                                                         if (result.count >0) {
                                                             if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                 NSMutableArray *arrResponse = [[NSMutableArray alloc] init];
                                                                 
                                                                     
                                                                     
                                                                     
                                                                 
                                                                     
                                                                     
                                                                 }
                                                                 [_CollectionViewIntrest reloadData];
                                                                 
                                                             }else{
                                                                 
                                                             }
                                                         }
                                                     
                                                     
                                                     
                                                 }];

}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [_CollectionViewIntrest dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 3.0f;
    [cell.layer setMasksToBounds:YES];
    
   
    
    
    UILabel *lblTitle = (UILabel *)[cell viewWithTag:20];
    // lblTitle.text = [keys objectAtIndex:indexPath.item];
    lblTitle.text = @"Fun";
    
    return cell;
}


- (IBAction)actionEdit:(id)sender {
}
@end
