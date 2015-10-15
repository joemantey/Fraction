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

@import Contacts;
@import ContactsUI;


@interface TransactionViewController () <UITextViewDelegate,  CNContactPickerDelegate >

@property (nonatomic) BOOL nameTextViewValid;
@property (nonatomic) BOOL amountTextViewValid;
@property (nonatomic) BOOL noteTextViewValid;

@property (nonatomic) CGFloat viewHeight;
@property (nonatomic) CGFloat keyboardHeight;


@property (strong, nonatomic) NSMutableString   *contactString;
@property (strong, nonatomic) NSMutableArray    *contactArray;


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *payChargeSegmentedControl;
@property (weak, nonatomic) IBOutlet UITextField        *nameTextView;
@property (weak, nonatomic) IBOutlet UITextField *amountLabelTextField;
@property (weak, nonatomic) IBOutlet UITextField        *amountTextView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegementedControl;
@property (weak, nonatomic) IBOutlet UITextView         *noteTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem    *submitButton;
@property (weak, nonatomic) IBOutlet UIButton           *completeTransactionButton;
@property (weak, nonatomic) IBOutlet UIButton           *addContactButton;

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
    [self addGestureRecognizer];
    
    self.viewHeight = self.view.frame.size.height;
    self.keyboardHeight = 260;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:@"keyboardDidShow" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:@"keyboardDidHide" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardOnScreen:) name:UIKeyboardDidShowNotification object:nil];


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


- (void)addGestureRecognizer{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

#pragma mark ABPeoplePicker Delegate

- (void)presentPeoplePicker{
    
    CNContactPickerViewController *picker   = [[CNContactPickerViewController alloc] init];
    picker.delegate                         = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}


-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(nonnull NSArray<CNContact *> *)contacts{

    
    self.contactArray = [NSMutableArray arrayWithArray:contacts];
    
    int counter = 0;
    for (CNContact *eachContact in self.contactArray) {
        
        if (counter == 0) {
            
            NSString *nameString    = [NSString stringWithFormat:@"%@ %@", eachContact.givenName, eachContact.familyName];
            self.contactString      = [NSMutableString stringWithFormat:@"%@", nameString];
            self.amountLabelTextField.text = @"Amount (in USD)";
            
        }else{
            
            NSString *nameString    = [NSString stringWithFormat:@", %@ %@", eachContact.givenName, eachContact.familyName];
            self.contactString      = [NSMutableString stringWithFormat:@"%@%@", self.contactString, nameString];
            
            self.amountLabelTextField.text = @"Amount per person (in USD)";

        }
        
        self.nameTextView.text  = self.contactString;
        
        counter++;
    }
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


- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardDidShow" object:nil];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardDidHide" object:nil];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.viewHeight)];
                         self.titleLabel.textColor = [UIColor whiteColor];
                         self.backButton.tintColor = [UIColor whiteColor];
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
}

-(void)keyboardOnScreen:(NSNotification *)notification
{
    NSDictionary *info  = notification.userInfo;
    NSValue      *value = info[UIKeyboardFrameEndUserInfoKey];
    
    CGRect rawFrame         = [value CGRectValue];
    CGRect keyboardFrame    = [self.view convertRect:rawFrame fromView:nil];
    self.keyboardHeight     = keyboardFrame.size.height;
    
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         [self.view setFrame:CGRectMake(0,-self.keyboardHeight,self.view.frame.size.width,self.viewHeight)];
                         self.titleLabel.textColor = [UIColor clearColor];
                         self.backButton.tintColor = [UIColor clearColor];
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                     }];
    
}

-(void)textViewDidChange:(UITextView *)textView{
    [self checkIfAllFieldsAreComplete];
}


-(void)textViewDidEndEditing:(UITextView *)textView{
    [self checkIfAllFieldsAreComplete];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma mark Action Methods

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

-(void)dismissKeyboard {
    [self.amountTextView resignFirstResponder];
    [self.noteTextView resignFirstResponder];
}
@end
