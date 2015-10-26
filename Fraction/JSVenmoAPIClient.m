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
    
    self.dataStore                  = [JSCoreData sharedDataStore];
    CGFloat numberOfContacts        = [inputPhoneNumberArray count]+[contacts count];
    CGFloat percentageofContacts    = 1/numberOfContacts;
    
    for (NSString *phoneNumber in inputPhoneNumberArray) {
        
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:self.dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = phoneNumber;
        newVenPerson.displayName        = phoneNumber;
        newVenPerson.transactionAmount  = amount;
        newVenPerson.sharePercentage    = [NSString stringWithFormat:@"%f", percentageofContacts];
        
        [self.dataStore.currentPayCharge addPayChargeToPersonObject:newVenPerson];
    }
    
    for (CNContact *contact in contacts) {
        
        JSVenPerson *newVenPerson       = [NSEntityDescription insertNewObjectForEntityForName:@"JSVenPerson" inManagedObjectContext:self.dataStore.managedObjectContext];
        newVenPerson.phoneNumber        = [self returnPhoneNumberStringfromArray:contact.phoneNumbers];
        newVenPerson.displayName        = [NSString stringWithFormat:@"  %@ %@", contact.givenName, contact.familyName];
        newVenPerson.transactionAmount  = amount;
        newVenPerson.sharePercentage    = [NSString stringWithFormat:@"%f", percentageofContacts];
        
        [self.dataStore.currentPayCharge addPayChargeToPersonObject:newVenPerson];
    }
    
    [self.dataStore saveContext];
}


- (void )buildPayChargewithAmount:(NSString *)amount{
    
    self.dataStore          = [JSCoreData sharedDataStore];
    
    PayCharge *newCharge    = [NSEntityDescription insertNewObjectForEntityForName:@"JSPayCharge" inManagedObjectContext:self.dataStore.managedObjectContext];
    newCharge.amount        = amount;
    
    self.dataStore.currentPayCharge = newCharge;
    
    [self.dataStore saveContext];
}


-(void )refreshSplit{
    
    PayCharge *charge           = self.dataStore.currentPayCharge;
    NSArray *venPersonArray     = [charge.payChargeToPerson allObjects];
    int totalFromVenPersons     = 0;
    
    for (JSVenPerson *venPerson in venPersonArray) {
        
        totalFromVenPersons = totalFromVenPersons + [venPerson.transactionAmount floatValue];
    }
    
    charge.amountLeft       = [NSString stringWithFormat:@"%f",([charge.amount floatValue] - totalFromVenPersons )];
    
    for (JSVenPerson *venPerson in venPersonArray) {
        
        venPerson.sharePercentage   = [NSString stringWithFormat:@"%f", ([venPerson.transactionAmount floatValue]/totalFromVenPersons)];
    }
    
    [self.dataStore saveContext];
}



@end

