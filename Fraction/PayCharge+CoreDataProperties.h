//
//  PayCharge+CoreDataProperties.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/24/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PayCharge.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayCharge (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *amount;
@property (nullable, nonatomic, retain) NSString *audience;
@property (nullable, nonatomic, retain) NSString *isCharge;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSString *phoneNumbers;
@property (nullable, nonatomic, retain) NSString *requestURL;
@property (nullable, nonatomic, retain) NSString *amountLeft;
@property (nullable, nonatomic, retain) NSSet<JSVenPerson *> *payChargeToPerson;

@end

@interface PayCharge (CoreDataGeneratedAccessors)

- (void)addPayChargeToPersonObject:(JSVenPerson *)value;
- (void)removePayChargeToPersonObject:(JSVenPerson *)value;
- (void)addPayChargeToPerson:(NSSet<JSVenPerson *> *)values;
- (void)removePayChargeToPerson:(NSSet<JSVenPerson *> *)values;

@end

NS_ASSUME_NONNULL_END
