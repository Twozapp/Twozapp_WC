//
//  ChatListViewController.h
//  Twozapp
//
//  Created by Priya on 16/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableViewChatList;

@end
