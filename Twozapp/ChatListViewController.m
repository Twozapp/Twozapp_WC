//
//  ChatListViewController.m
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ChatListViewController.h"

@interface ChatListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChatListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *CellIdentifier = @"ChatCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImageView *imgViewProfilePic = (UIImageView *)[cell viewWithTag:10];
    imgViewProfilePic.layer.cornerRadius = 35.0f;
    [imgViewProfilePic.layer setMasksToBounds:YES];
    imgViewProfilePic.image = [UIImage imageNamed:@"imgSample.png"];
    
    UIImageView *imgViewOline = (UIImageView *)[cell viewWithTag:20];
    
    UILabel *lblName = (UILabel *)[cell viewWithTag:30];
    
    UILabel *lblChats = (UILabel *)[cell viewWithTag:40];
    
    UILabel *lblDate = (UILabel *)[cell viewWithTag:50];
    
    return cell;
}

@end
