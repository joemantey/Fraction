//
//  JSVenmoAPI.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 9/28/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSVenmoAPIClient.h"
#import "JSConstants.h"

#import "PayCharge.h"
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


#pragma mark - Process Contact Array Methods
- (NSString *)returnPhoneNumberStringfromArray:(NSArray<CNLabeledValue<CNPhoneNumber*>*> *)contactArray{
    
    NSMutableString *iPhonePhoneNumber = [NSMutableString stringWithFormat:@""];
    NSMutableString *mobilePhoneNumber = [NSMutableString stringWithFormat:@""];
    NSMutableString *mainPhoneNumber   = [NSMutableString stringWithFormat:@""];
    NSMutableString *otherPhoneNumber  = [NSMutableString stringWithFormat:@""];
    
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
    if (iPhonePhoneNumber.length > 4) {
        
        NSString *returnString = iPhonePhoneNumber;
        return returnString;
    }
    
    else if (mobilePhoneNumber.length > 4){
        
        NSString *returnString = mobilePhoneNumber;
        return returnString;
    }
    
    else if (mainPhoneNumber.length > 4){
        
        NSString *returnString = mainPhoneNumber;
        return returnString;
    }
    
    else{
        
        return otherPhoneNumber;
    }
}


- (void )processContactArraysInputArray:(NSArray *)inputPhoneNumberArray
                        andContactArray:(nonnull NSArray<CNContact *> *)contacts
                              andAmount:(NSString *)amount{
    
    self.dataStore =[JSCoreData sharedDataStore];
    
    for (NSString *phoneNumber in inputPhoneNumberArray) {
        
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:self.dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = phoneNumber;
        newVenPerson.displayName        = phoneNumber;
        newVenPerson.transactionAmount  = amount;
    }
    
    for (CNContact *contact in contacts) {
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:self.dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = [self returnPhoneNumberStringfromArray:contact.phoneNumbers];
        newVenPerson.displayName        = [NSString stringWithFormat:@", %@ %@", contact.givenName, contact.familyName];
        newVenPerson.transactionAmount  = amount;
    }
    
    [self.dataStore saveContext];
}











@end

