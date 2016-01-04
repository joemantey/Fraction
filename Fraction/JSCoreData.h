//
//  JSCoreData.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/15/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenPerson.h"
#import "PayCharge.h"
#import "JSCharge.h"

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import <Venmo-iOS-SDK/Venmo.h>


@interface JSCoreData : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) BOOL didGainPermissions;

@property (strong, nonatomic) NSMutableArray    *inputPhoneNumberArray;
@property (strong, nonatomic) PayCharge         *currentPayCharge;
@property (strong, nonatomic) JSCharge          *currentCharge;

@property (strong, nonatomic) NSString          *noteString;
@property (nonatomic)         NSInteger          privacyPickerIndex;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

#pragma mark - Core Data Saving support
+ (instancetype) sharedDataStore;

#pragma mark - VenPersons
- (NSArray *)fetchVenPersons;
- (void)deleteVenPersons;

#pragma mark - PayCharge


@end
