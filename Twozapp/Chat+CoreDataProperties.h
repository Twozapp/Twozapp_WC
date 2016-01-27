//
//  Chat+CoreDataProperties.h
//  Twozapp
//
//  Created by Dipin on 27/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Chat.h"

NS_ASSUME_NONNULL_BEGIN

@interface Chat (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *datetime;
@property (nullable, nonatomic, retain) NSString *friendid;
@property (nullable, nonatomic, retain) NSData *imagedata;
@property (nullable, nonatomic, retain) NSString *imageurl;
@property (nullable, nonatomic, retain) NSString *message;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *senderid;
@property (nullable, nonatomic, retain) NSManagedObject *chathistory;

@end

NS_ASSUME_NONNULL_END
