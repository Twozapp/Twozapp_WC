//
//  MatchesViewController.m
//  Twozapp
//
//  Created by Priya on 10/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "MatchesViewController.h"
#import "NetworkManager.h"
#import "UserFriends.h"

@interface MatchesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *arrayMatches;
}
@end

@implementation MatchesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayMatches = [[NSMutableArray alloc] init];
    //infowebtechsolutions.com/demo/twzapp/match.php?user_id=11
    NSString  *urlPath    = [NSString stringWithFormat:@"http://infowebtechsolutions.com/demo/twzapp/match.php?user_id=1"];
    
    [[NetworkManager sharedManager] getvalueFromServerForGetterURL:urlPath
                                                 completionHandler:^(NSError *error, NSDictionary *result) {
                                                     if(error) {
                                                         NSLog(@"error : %@", [error description]);
                                                     } else {
                                                         // This is the expected result
                                                         NSLog(@"result : %@", result);
                                                         if (result.count >0) {
                                                             if ([result[@"response"][@"Success"] isEqualToString:@"1"]) {
                                                                 NSMutableArray *arrResponse = [[NSMutableArray alloc] init];
                                                                 arrResponse = result[@"response"][@"Details"];
                                                                 for (int i = 0; i< [arrResponse count]; i++) {
                                                                     UserFriends *userFriends = [[UserFriends alloc] init];
                                                                     userFriends.fndImage = [[arrResponse objectAtIndex:i] objectForKey:@"profile_picture1"];
                                                                     userFriends.fndEmail = [[arrResponse objectAtIndex:i] objectForKey:@"email"];
                                                                     userFriends.frdName = [[arrResponse objectAtIndex:i] objectForKey:@"full_name"];
                                                                                                                                          userFriends.frdLat = [[arrResponse objectAtIndex:i] objectForKey:@"latitude"];
                                                                                                                                          userFriends.frdLong = [[arrResponse objectAtIndex:i] objectForKey:@"logitude"];
                                                                                                                                          userFriends.fndDescription = [[arrResponse objectAtIndex:i] objectForKey:@"description"];
                                                                                                                                          userFriends.fndGender = [[arrResponse objectAtIndex:i] objectForKey:@"gender"];
                                                                     userFriends.frdId = [[arrResponse objectAtIndex:i] objectForKey:@"id"];
                                                                     
                                                                     
                                                                     
                                                                     [arrayMatches addObject:userFriends];
                                                                     
                                                                     
                                                                 }
                                                                 [_collectionView reloadData];
                            
                                                             }else{
                                                                 
                                                             }
                                                         }
                                                     }
                                                 
     
                                                                 
                                                 }];
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
    return [arrayMatches count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    UserFriends *userFriends = [arrayMatches objectAtIndex:indexPath.item];
    
    UIImageView *imgViewProfile = (UIImageView *)[cell viewWithTag:10];
    imgViewProfile.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",userFriends.fndImage]];
    imgViewProfile.layer.cornerRadius = 5.0;
    [imgViewProfile.layer setMasksToBounds:YES];
    
    UIView *viewName = (UIView *)[cell viewWithTag:30];
    viewName.layer.cornerRadius = 5.0;
    [viewName.layer setMasksToBounds:YES];
    
    UILabel *lblName = (UILabel *)[cell viewWithTag:40];
    lblName.text = userFriends.frdName;
    
    UIImageView *imgOnline = (UIImageView *)[cell viewWithTag:20];
    imgOnline.layer.cornerRadius = 5.0;
    [imgOnline.layer setMasksToBounds:YES];
    
        return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
        CGFloat side = collectionView.frame.size.width/2-10;
        return CGSizeMake(side, side);
}
@end
