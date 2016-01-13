//
//  JSVenmoAPI.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenmoAPIClient.h"
#import "JSConstants.h"
#import "JSCoreData.h"

#import "PayCharge.h"
#import "JSCharge.h"
#import "JSVenPerson.h"

#import <Venmo-iOS-SDK/Venmo.h>


@implementation JSVenmoAPIClient


#pragma mark - Shared Venmo API Client

static JSVenmoAPIClient * venmoAPIClient;

+(JSVenmoAPIClient *)sharedInstance{
    
    if (nil == venmoAPIClient) {
        venmoAPIClient = [[JSVenmoAPIClient alloc]init];
    }
    return venmoAPIClient;
}

#pragma mark - Send Money Methods

- (void)executeChargeWithPhoneNumber:(NSString *)phoneNumbers
                           andAmount:(NSString *)amount
                             andNote:(NSString *)note
                         andAudience:(NSString *)audience{
    
    [[Venmo sharedInstance] sendPaymentTo:phoneNumbers
                                   amount:amount.floatValue
                                     note:note
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                NSLog(@"Transaction succeeded!");
                            }
                            else {
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
}

-(void)executeCharge:(JSCharge *)charge{
    
    NSArray *friendArray    = charge.friend.allObjects;
    
    //on the first run of the method, go through and assign all of the friend objects an index
    if (charge.index == 0) {
        
        NSNumber *chargeIndex = charge.index;
        charge.index = [NSNumber numberWithFloat:( charge.index.floatValue + 1)];
        
        int  i = 0;
        for (i = 0; i < friendArray.count; i++) {
            
            JSFriend *friend    = friendArray[i];
            friend.index        = [NSNumber numberWithInt: i];
        }
        
       JSFriend *friendToCharge = [self returnFriendFromArray:friendArray forIndex:chargeIndex];
    
    }
    
    
    
    
    /*
     -execute charges until they are done
        -first run (charge.index = 0)
            -assign all of the friends an index
            -increment charge index to 1
            -run the friend.index = 0
                -that query calls the method again if the count of friends is =< charge index
        -subsequent runs (charge.index > 0)
            -increment the charge index +1 (so 2 on the third run)
            -run the friend.index = charge.index
            -that query calls the method again if the count of friends is =< charge index

    */
    
    
}


-(JSFriend *)returnFriendFromArray:(NSArray *)friendArray forIndex:(NSNumber *)index{
    
    
    NSMutableArray *returnArray = [NSMutableArray array];
    for (JSFriend *friend in friendArray) {
        if (friend.index == index){
            [returnArray addObject:friend];
        }
    }
    
    return returnArray.firstObject;
}

-(void)executeAPIChargeWithFriend:(JSFriend *)friend{
    
    [[Venmo sharedInstance] sendPaymentTo:friend.phoneNumber
                                   amount:friend.pledgedAmount.integerValue
                                     note:friend.charge.note
                        completionHandler:^(VENTransaction *transaction, BOOL success, NSError *error) {
                            if (success) {
                                
                                friend.chargeExecuted   = [NSNumber numberWithBool:YES];
                                friend.chargeSuccesful  = [NSNumber numberWithBool:YES];
                                if ([self shouldRunCharge:friend.charge]) {
                                    [self executeCharge:friend.charge];
                                }
                            
                            }
                            else {
                                friend.chargeExecuted   = [NSNumber numberWithBool:YES];
                                friend.chargeSuccesful  = [NSNumber numberWithBool:NO];
                                friend.errorString      = [error localizedDescription];
                                if ([self shouldRunCharge:friend.charge]) {
                                    [self executeCharge:friend.charge];
                                }
                                NSLog(@"Transaction failed with error: %@", [error localizedDescription]);
                            }
                        }];
}

-(BOOL)shouldRunCharge:(JSCharge *)charge{
    
    if (charge.friend.count > charge.index.integerValue ) {
        
        return YES;
    }else{
        
        return NO;
    }
    
}

#pragma mark - Process Contact Array Methods


+ (NSString *)returnPhoneNumberStringfromArray:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)contactArray{
    
    CNPhoneNumber *iPhonePhoneNumber = [[CNPhoneNumber alloc]init];
    CNPhoneNumber *mobilePhoneNumber = [[CNPhoneNumber alloc]init];
    CNPhoneNumber *mainPhoneNumber   = [[CNPhoneNumber alloc]init];
    CNPhoneNumber *otherPhoneNumber  = [[CNPhoneNumber alloc]init];
    
    //fill the assoated string if it matches the correct label
    for (CNLabeledValue *eachContact in contactArray) {
        
        if (eachContact.label == CNLabelPhoneNumberiPhone ) {
            iPhonePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMobile ) {
            mobilePhoneNumber = eachContact.value;
        }
        
        else if (eachContact.label == CNLabelPhoneNumberMain) {
            mainPhoneNumber   = eachContact.value;
        }
        
        else {
            otherPhoneNumber  = eachContact.value;
        }
    }
    
    //return whatever the iphone is first, then mobile, then main
    if ([iPhonePhoneNumber stringValue].length > 4) {
        
        NSString *returnString = [iPhonePhoneNumber stringValue];
        return returnString;
    }
    
    else if ([mobilePhoneNumber stringValue].length > 4){
        
        NSString *returnString = [mobilePhoneNumber stringValue];
        return returnString;
    }
    
    else if ([mainPhoneNumber stringValue].length > 4){
        
        NSString *returnString = [mainPhoneNumber stringValue];
        return returnString;
    }
    
    else{
        
        return [otherPhoneNumber stringValue];
    }
}


- (void )processContactArraysInputArray:(NSArray *)inputPhoneNumberArray
                        andContactArray:(nonnull NSArray<CNContact *> *)contacts
                              andAmount:(NSString *)amount{
    
    JSCoreData *dataStore           = [JSCoreData sharedDataStore];
    CGFloat numberOfContacts        = [inputPhoneNumberArray count]+[contacts count];
    CGFloat percentageofContacts    = 1/numberOfContacts;
    
    for (NSString *phoneNumber in inputPhoneNumberArray) {
        
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = phoneNumber;
        newVenPerson.displayName        = phoneNumber;
        newVenPerson.transactionAmount  = amount;
        newVenPerson.sharePercentage    = [NSString stringWithFormat:@"%f", percentageofContacts];
        
        [dataStore.currentPayCharge addPayChargeToPersonObject:newVenPerson];
    }
    
    for (CNContact *contact in contacts) {
        
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = [JSVenmoAPIClient returnPhoneNumberStringfromArray:contact.phoneNumbers];
        newVenPerson.displayName        = [NSString stringWithFormat:@"  %@ %@", contact.givenName, contact.familyName];
        newVenPerson.transactionAmount  = amount;
        newVenPerson.sharePercentage    = [NSString stringWithFormat:@"%f", percentageofContacts];
        
        [dataStore.currentPayCharge addPayChargeToPersonObject:newVenPerson];
    }
    
    [dataStore saveContext];
}


- (void )buildPayChargewithAmount:(NSString *)amount{
    
    JSCoreData *dataStore   = [JSCoreData sharedDataStore];
    
    PayCharge *newCharge    = [NSEntityDescription insertNewObjectForEntityForName:@"JSPayCharge" inManagedObjectContext:dataStore.managedObjectContext];
    newCharge.amount        = amount;
    
    dataStore.currentPayCharge = newCharge;
    
    [dataStore saveContext];
}


-(void)splitAmount{
    
    JSCoreData *dataStore           = [JSCoreData sharedDataStore];
    NSMutableArray *friendArray     = [[NSMutableArray alloc]initWithArray: dataStore.currentCharge.friend.allObjects];

    if (dataStore.currentCharge.selfIncluded) {
        [friendArray insertObject:dataStore.currentCharge.me atIndex:0];
    }
    
    float amountEach        = dataStore.currentCharge.amount.floatValue /friendArray.count;
    
    NSLog(@"amount each %f", amountEach);
    for (JSFriend *friend in friendArray) {
        friend.pledgedAmount    = [NSNumber numberWithFloat:amountEach];
        friend.shareOfAmount    = [NSNumber numberWithFloat:(1/friendArray.count)];
    }
    
   
    
    
    [dataStore saveContext];
}

- (void)refreshSplit{
    
    JSCoreData *dataStore           = [JSCoreData sharedDataStore];
    NSMutableArray *friendArray     = [[NSMutableArray alloc]initWithArray: dataStore.currentCharge.friend.allObjects];

    if (dataStore.currentCharge.selfIncluded) {
        [friendArray insertObject:dataStore.currentCharge.me atIndex:0];
    }
    
    int totalFromFriends    = 0;
    
    for (JSFriend *friend in friendArray) {
        totalFromFriends    = totalFromFriends + [friend.pledgedAmount floatValue];
    }
    
    dataStore.currentCharge.amountLeft       = [NSNumber numberWithFloat: dataStore.currentCharge.amount.floatValue - totalFromFriends];
    
    for (JSFriend *friend in friendArray) {
        
        friend.shareOfAmount= [NSNumber numberWithFloat: ([friend.pledgedAmount floatValue]/dataStore.currentCharge.amount.floatValue)];
    }
    
    [dataStore saveContext];
}



@end

