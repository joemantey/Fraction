//
//  JSVenPerson+CoreDataProperties.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/24/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "JSVenPerson.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSVenPerson (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *displayName;
@property (nullable, nonatomic, retain) NSString *transactionAmount;
@property (nullable, nonatomic, retain) NSString *sharePercentage;
@property (nullable, nonatomic, retain) PayCharge *personToCharge;

@end

NS_ASSUME_NONNULL_END
