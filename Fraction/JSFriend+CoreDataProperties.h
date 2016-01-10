//
//  JSFriend+CoreDataProperties.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 1/7/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JSFriend.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSFriend (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *about;
@property (nullable, nonatomic, retain) NSString *displayName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSNumber *pledgedAmount;
@property (nullable, nonatomic, retain) NSString *profilePictureURL;
@property (nullable, nonatomic, retain) NSNumber *shareOfAmount;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSString *username;
@property (nullable, nonatomic, retain) JSCharge *charge;

@end

NS_ASSUME_NONNULL_END
