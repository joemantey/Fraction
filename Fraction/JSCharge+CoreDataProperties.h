//
//  JSCharge+CoreDataProperties.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 1/8/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JSCharge.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSCharge (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *amount;
@property (nullable, nonatomic, retain) NSNumber *amountLeft;
@property (nullable, nonatomic, retain) NSString *audience;
@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSDate *dateOfCharge;
@property (nullable, nonatomic, retain) NSNumber *isCharge;
@property (nullable, nonatomic, retain) NSNumber *isDelayedCharge;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *phoneNumbers;
@property (nullable, nonatomic, retain) NSString *requestURL;
@property (nullable, nonatomic, retain) NSNumber *tip;
@property (nullable, nonatomic, retain) NSNumber *selfIncluded;
@property (nullable, nonatomic, retain) NSSet<JSFriend *> *friend;
@property (nullable, nonatomic, retain) NSManagedObject *person;
@property (nullable, nonatomic, retain) JSFriend *me;

@end

@interface JSCharge (CoreDataGeneratedAccessors)

- (void)addFriendObject:(JSFriend *)value;
- (void)removeFriendObject:(JSFriend *)value;
- (void)addFriend:(NSSet<JSFriend *> *)values;
- (void)removeFriend:(NSSet<JSFriend *> *)values;

@end

NS_ASSUME_NONNULL_END
