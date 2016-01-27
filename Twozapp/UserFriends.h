//
//  UserFriends.h
//  Twozapp
//
//  Created by Priya on 20/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserFriends : NSObject
@property (nonatomic, strong) NSString *frdName;
@property (nonatomic, strong) NSString *frdId;
@property (nonatomic, strong) NSString *frdLat;
@property (nonatomic, strong) NSString *frdLong;
@property (nonatomic, strong) NSString *fndImage;
@property (nonatomic, strong) NSString *fndGender;
@property (nonatomic, strong) NSString *fndDescription;
@property (nonatomic, strong) NSString *fndEmail;
@property (nonatomic, strong) NSString *fndBaziCount;

@end
