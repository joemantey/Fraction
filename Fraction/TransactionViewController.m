//
//  TransactionViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/5/15.
//  Copyright (c) 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "TransactionViewController.h"
#import <Venmo-iOS-SDK/Venmo.h>

@import AddressBook;
@import AddressBookUI;


@interface TransactionViewController () <UITextViewDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic) BOOL nameTextViewValid;
@property (nonatomic) BOOL amountTextViewValid;
@property (nonatomic) BOOL noteTextViewValid;
@property (strong, nonatomic) NSMutableString *contactString;

@property (weak, nonatomic) IBOutlet UISegmentedControl *payChargeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegementedControl;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *completeTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton *addContactButton;

- (IBAction)didSelectPayCharge:(id)sender;
- (IBAction)didSelectPrivacy:(id)sender;
- (IBAction)didTapBackButton:(id)sender;
- (IBAction)didTapSubmitButton:(id)sender;
- (IBAction)didTapCompleteTransactionButton:(id)sender;
- (IBAction)didFinishEditingNameField:(id)sender;


- (IBAction)didFinishEditingAmount:(id)sender;
- (IBAction)didTapAddContact:(id)sender;

@end

@implementation TransactionViewController


#pragma mark View Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self clearNavigationBar];
    [self setUpViewsAndButtons];
    [self setBackgroundColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearNavigationBar{
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor clearColor];
}


- (void)setBackgroundColor{
    
    UIColor *startColor         = [UIColor colorWithRed:0.108 green:0.649 blue:0.683 alpha:1.000];
    UIColor *endColor           = [UIColor colorWithRed:0.108 green:0.649 blue:0.683 alpha:1.000];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];

}

- (void)setUpViewsAndButtons{
    
    self.nameTextView.layer.cornerRadius        = 8;
    self.nameTextView.layer.borderWidth         = 1;
    self.nameTextView.layer.borderColor         = [[UIColor whiteColor]CGColor];
    self.nameTextView.clipsToBounds             = YES;
    [self.nameTextView becomeFirstResponder];
    
    self.addContactButton.layer.cornerRadius    = 8;
    self.addContactButton.layer.borderWidth     = 1;
    self.addContactButton.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.addContactButton.clipsToBounds         = YES;
    
    self.amountTextView.layer.cornerRadius      = 8;
    self.amountTextView.layer.borderWidth       = 1;
    self.amountTextView.layer.borderColor       = [[UIColor whiteColor]CGColor];
    self.amountTextView.clipsToBounds           = YES;
    
    self.noteTextView.layer.cornerRadius        = 8;
    self.noteTextView.layer.borderWidth         = 1;
    self.noteTextView.layer.borderColor         = [[UIColor whiteColor]CGColor];
    self.noteTextView.clipsToBounds             = YES;
    self.noteTextView.delegate                  = self;
    
    self.completeTransactionButton.layer.cornerRadius    = 8;
    self.completeTransactionButton.layer.borderWidth     = 1;
    self.completeTransactionButton.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.completeTransactionButton.clipsToBounds         = YES;
    [self.completeTransactionButton setTitle:@"Please complete all fields" forState:UIControlStateNormal];
    self.completeTransactionButton.userInteractionEnabled= NO;
}


#pragma mark ABPeoplePicker Delegate

- (void)presentPeoplePicker{
    
    ABPeoplePickerNavigationController *picker  = [[ABPeoplePickerNavigationController alloc] init];
    picker.peoplePickerDelegate                 = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)addNameToStrongFrom:(ABRecordRef)person{
    
    self.contactString      = [NSMutableString stringWithFormat:@"%@", self.nameTextView.text];
    
    NSString *firstName     =  (__bridge_transfer NSString*)ABRecordCopyValue(person,kABPersonCompositeNameFormatFirstNameFirst);
    NSString *lastName     =  (__bridge_transfer NSString*)ABRecordCopyValue(person,kABPersonCompositeNameFormatLastNameFirst);
    
    NSString *nameToAdd     =  [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    
    if ([self.nameTextView.text length] == 0 ||
         self.nameTextView.text == nil       ||
        [self.nameTextView.text isEqual:@""] == TRUE)
    {
        self.contactString      = [NSMutableString stringWithFormat: @"%@", nameToAdd];
    }
    else
    {
        self.contactString      = [NSMutableString stringWithFormat: @"%@, %@", self.contactString, nameToAdd];

    }
    
    self.nameTextView.text  = self.contactString;
    
}


- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


 -(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person{
    
    //do something with the person object passed here
    
    [self addNameToStrongFrom:person];
    
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL)peoplePickerNavigationController:
(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
    
}



#pragma mark Entry Field Methods
- (BOOL)checkNameFieldIsNotEmpty{
    
    if ([self.nameTextView.text length] > 0){
       
        self.nameTextViewValid = YES;
        return YES;
    }
    else{
        
        self.nameTextViewValid = NO;
        return NO;
    }
    
}


- (BOOL)checkIfAmountFieldIsCompletedCorrectly{
    
    if ([self.amountTextView.text length] > 0){
        
        self.amountTextViewValid = YES;
        return YES;
    }
    else{
        
        self.amountTextViewValid = NO;
        return NO;
    }
}

- (BOOL)checkIfNoteFieldIsNotEmpty{
    
    if ([self.noteTextView.text length] > 0){
        
        self.noteTextViewValid = YES;
        return YES;
    }
    else{
        
        self.noteTextViewValid = NO;
        return NO;
    }
}


- (BOOL)checkIfAllFieldsAreComplete{
    
    [self checkIfAmountFieldIsCompletedCorrectly];
    [self checkIfNoteFieldIsNotEmpty];
    [self checkNameFieldIsNotEmpty];
    
    if (self.noteTextViewValid   == YES &&
        self.amountTextViewValid == YES &&
        self.nameTextViewValid   == YES) {
        
        self.completeTransactionButton.backgroundColor   =  [UIColor whiteColor];
        self.completeTransactionButton.layer.borderColor = [[UIColor whiteColor]CGColor];

        [self.completeTransactionButton setTitleColor:[UIColor colorWithRed:0.108 green:0.649 blue:0.683 alpha:1.000]
                                             forState:UIControlStateNormal];
        
        [self.completeTransactionButton setTitle:@"Complete transaction" forState:UIControlStateNormal];
        
        return YES;
    }
    else{
        
        
        self.completeTransactionButton.backgroundColor   =  [UIColor colorWithWhite:1 alpha:0.25];
        self.completeTransactionButton.layer.borderColor = [[UIColor whiteColor]CGColor];
        
        [self.completeTransactionButton setTitleColor:[UIColor whiteColor]
                                             forState:UIControlStateNormal];
        
        [self.completeTransactionButton setTitle:@"Please complete all fields" forState:UIControlStateNormal];
        
        return NO;
    }
}



#pragma mark UITextView Delegate

-(void)textViewDidBeginEditing:(UITextView *)textView{

    [self checkIfAllFieldsAreComplete];
}


-(void)textViewDidChange:(UITextView *)textView{
    [self checkIfAllFieldsAreComplete];
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    [self checkIfAllFieldsAreComplete];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma Mark Action Methods

- (IBAction)didSelectPayCharge:(id)sender {
    
    [self checkIfAllFieldsAreComplete];
}


- (IBAction)didSelectPrivacy:(id)sender {
    
    [self checkIfAllFieldsAreComplete];
}


- (IBAction)didTapCompleteTransactionButton:(id)sender {
    
    [self checkIfAllFieldsAreComplete];
}


- (IBAction)didFinishEditingNameField:(id)sender {
    
    [self checkIfAllFieldsAreComplete];
}


- (IBAction)didTapAddContact:(id)sender {
    
    [self presentPeoplePicker];
}

- (IBAction)didFinishEditingAmount:(id)sender {
    
    [self checkIfAllFieldsAreComplete];
}




- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didTapSubmitButton:(id)sender {
}
@end
