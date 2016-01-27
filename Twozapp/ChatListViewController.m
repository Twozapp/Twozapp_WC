//
//  ChatListViewController.m
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ChatListViewController.h"
#import "NetworkManager.h"
#import "UserDetails.h"
#import "AppDelegate.h"
#import "ChatSummary.h"
#import "Chat.h"

@interface ChatListViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *chatsummarys;
}
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

- (void)getChatList
{
    NSString  *urlPath    = [NSString stringWithFormat:@"infowebtechsolutions.com/demo/twzapp/chat_list.php?user_id=%@",[UserDetails sharedInstance].user_id];
    
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
                                                                 
                                                                 
                                                                 for (NSDictionary *dict in arrResponse) {
                                                                     
                                                                     if ([dict[@"from_id"] isEqualToString:[UserDetails sharedInstance].user_id]) {
                                                                         if ([[self checkChatSummaryExist:dict[@"to_id"]] count] == 0) {
                                                                             ChatSummary *chatSummary = (ChatSummary *)[NSEntityDescription insertNewObjectForEntityForName:@"ChatSummary"
                                                                                                                                                     inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chatSummary.friend_id = dict[@"to_id"];
                                                                             chatSummary.datetime = dict[@"date_time"];
                                                                             chatSummary.lastmessage = dict[@"message_body"];
                                                                             chatSummary.name = dict[@"to_id"];
                                                                             
                                                                             [self saveManageObject];
                                                                             Chat *chat = (Chat *)[NSEntityDescription insertNewObjectForEntityForName:@"Chat"
                                                                                                                                                     inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chat.senderid = dict[@"to_id"];
                                                                             chat.friendid = dict[@"to_id"];
                                                                             chat.datetime = dict[@"date_time"];
                                                                             chat.message = dict[@"message_body"];
                                                                             [chatSummary addChatsObject:chat];
                                                                             
                                                                             [self saveManageObject];
                                                                             
                                                                         }
                                                                         else
                                                                         {
                                                                             ChatSummary *chatsummary = (ChatSummary *)[self checkChatSummaryExist:dict[@"to_id"]][0];
                                                                             
                                                                             Chat *chat = (Chat *)[NSEntityDescription insertNewObjectForEntityForName:@"Chat"
                                                                                                                                inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chat.senderid = dict[@"to_id"];
                                                                             chat.friendid = dict[@"to_id"];
                                                                             chat.datetime = dict[@"date_time"];
                                                                             chat.message = dict[@"message_body"];
                                                                             [chatsummary addChatsObject:chat];
                                                                             
                                                                             [self saveManageObject];

                                                                         }
                                                                     }
                                                                     else
                                                                     {
                                                                         if ([[self checkChatSummaryExist:dict[@"from_id"]] count] == 0) {
                                                                             ChatSummary *chatSummary = (ChatSummary *)[NSEntityDescription insertNewObjectForEntityForName:@"ChatSummary"
                                                                                                                                                     inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chatSummary.friend_id = dict[@"from_id"];
                                                                             chatSummary.datetime = dict[@"date_time"];
                                                                             chatSummary.lastmessage = dict[@"message_body"];
                                                                             chatSummary.name = dict[@"to_id"];
                                                                             
                                                                             [self saveManageObject];
                                                                             Chat *chat = (Chat *)[NSEntityDescription insertNewObjectForEntityForName:@"Chat"
                                                                                                                                inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chat.senderid = dict[@"to_id"];
                                                                             chat.friendid = dict[@"to_id"];
                                                                             chat.datetime = dict[@"date_time"];
                                                                             chat.message = dict[@"message_body"];
                                                                             [chatSummary addChatsObject:chat];
                                                                             
                                                                             [self saveManageObject];
                                                                         }
                                                                         else
                                                                         {
                                                                             ChatSummary *chatsummary = (ChatSummary *)[self checkChatSummaryExist:dict[@"from_id"]][0];
                                                                             
                                                                             Chat *chat = (Chat *)[NSEntityDescription insertNewObjectForEntityForName:@"Chat"
                                                                                                                                inManagedObjectContext:[[self appDelegate] managedObjectContext]];
                                                                             chat.senderid = dict[@"to_id"];
                                                                             chat.friendid = dict[@"to_id"];
                                                                             chat.datetime = dict[@"date_time"];
                                                                             chat.message = dict[@"message_body"];
                                                                             [chatsummary addChatsObject:chat];
                                                                             
                                                                             [self saveManageObject];
                                                                         }
                                                                     }
                                                                     
                                                                     
                                                                     
                                                                     
                                                                 }
                                                                 chatsummarys = [self fetchChatSummary];
                                                                 [_tableViewChatList reloadData];
                                                                 
                                                             }else{
                                                                 
                                                             }
                                                         }
                                                     }
                                                     
                                                     
                                                     
                                                 }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatsummarys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
static NSString *CellIdentifier = @"ChatCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UIImageView *imgViewProfilePic = (UIImageView *)[cell viewWithTag:10];
    imgViewProfilePic.layer.cornerRadius = 35.0f;
    [imgViewProfilePic.layer setMasksToBounds:YES];
    imgViewProfilePic.image = [UIImage imageNamed:@"imgSample.png"];
    
    ChatSummary *chatSummary = chatsummarys[indexPath.row];
    UIImageView *imgViewOline = (UIImageView *)[cell viewWithTag:20];
    
    UILabel *lblName = (UILabel *)[cell viewWithTag:30];
    
    UILabel *lblChats = (UILabel *)[cell viewWithTag:40];
    
    UILabel *lblDate = (UILabel *)[cell viewWithTag:50];
    
    return cell;
}

- (AppDelegate *)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

-(BOOL)saveManageObject{
    NSError *error = nil;
    if ([[[self appDelegate] managedObjectContext] save:&error]) {
        
        return YES;
    }else{
        ////NSLog(@"Database Save error :%@",[error description]);
    }
    return NO;
}

- (NSArray *)checkChatSummaryExist:(NSString *)friendId
{
    NSError *error;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ChatSummary"];
    request.predicate = [NSPredicate predicateWithFormat:@"friend_id == %@",friendId];
    
    NSArray *array = [[[self appDelegate] managedObjectContext] executeFetchRequest:request error:&error];
    
    return array;
}

- (NSArray *)fetchChatSummary
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"ChatSummary"];
    NSError *error;
    NSArray *array = [[[self appDelegate] managedObjectContext] executeFetchRequest:request error:&error];
    
    return array;
}

@end
