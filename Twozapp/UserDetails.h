//
//  UserDetails.h
//  Twozapp
//
//  Created by Dipin on 20/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDetails : NSObject


@property (nonatomic, strong) NSString *chinese_element;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *day_column_one;
@property (nonatomic, strong) NSString *day_column_two;
@property (nonatomic, strong) NSString *descriptions;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fb_id;
@property (nonatomic, strong) NSString *full_name;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *hr_mm_column_one;
@property (nonatomic, strong) NSString *hr_mm_column_two;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *last_online;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *logitude;
@property (nonatomic, strong) NSString *modified_date;
@property (nonatomic, strong) NSString *month_column_one;
@property (nonatomic, strong) NSString *month_column_two;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *year_column_one;
@property (nonatomic, strong) NSString *year_column_two;
@property (nonatomic, strong) NSString *zodiac_animal;
@property (nonatomic, strong) NSString *status;

+ (UserDetails *)sharedInstance;

@end
