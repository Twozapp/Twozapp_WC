//
//  UserDetails.m
//  Twozapp
//
//  Created by Dipin on 20/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "UserDetails.h"

@implementation UserDetails

@synthesize chinese_element, date,day_column_one, day_column_two, descriptions, email, fb_id, full_name, gender, hr_mm_column_one, hr_mm_column_two, user_id, last_online, latitude, logitude, modified_date, month_column_one, month_column_two, password, status, year_column_one, year_column_two, zodiac_animal;

#pragma mark - Singleton methods

+ (UserDetails*)sharedInstance
{
    static UserDetails *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[[self class] alloc] init];
        
        
    });
    return sharedInstance;
}


@end
