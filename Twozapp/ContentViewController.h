//
//  ContentViewController.h
//  Twozapp
//
//  Created by Dipin on 21/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RNFrostedSidebar.h"

@interface ContentViewController : UIViewController<RNFrostedSidebarDelegate>
- (IBAction)actionMenu:(id)sender;

@end
