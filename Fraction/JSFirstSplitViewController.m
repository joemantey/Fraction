//
//  JSFirstSplitViewController.m
//  Fraction
//
//  Created by Norma Smalls-Mantey on 12/30/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

/*
 
 
Formatting: 
 
x-create custom cells in IB
x-create background class for cells
x-method for creating white borders around cells
 
 
Process:
 
x-method create new version of charge
-method to attatching contacts to it (person class)
-wipe and reattach contacts to the charge everytime it is changes
-method to make sure before segue you have evrything
-methods for pop for entering phone number with choice to enter another
-method to delete contact from tableview and charge
 */


#import "JSFirstSplitViewController.h"
#import "JSCoreData.h"
#import "JSCharge.h"
#import "JSFriend.h"
#import "JSVenmoAPIClient.h"

#import "UIColor+Colors.h"
#import "NSString+Formatting.h"

@interface JSFirstSplitViewController () <UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;
@property (strong, nonatomic) JSVenmoAPIClient  *venmoAPIClient;

@property (nonatomic)         BOOL              contactsAdded;
@property (strong, nonatomic) NSMutableString   *contactString;
@property (strong, nonatomic) NSMutableArray    *contactArray;
@property (nonatomic)         NSInteger         contactCount;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (weak, nonatomic) IBOutlet UISwitch *includeSelfSwitch;
@property (weak, nonatomic) IBOutlet UIButton *addressBookButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberButton;
@property (weak, nonatomic) IBOutlet UIView *bottomFadeView;
@property (weak, nonatomic) IBOutlet UIView *topFadeView;

@property (weak, nonatomic) IBOutlet UITableView *contactTableView;




- (IBAction)backButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;
- (IBAction)includeSelfSwitchChanged:(id)sender;
- (IBAction)addressBookButtonTapped:(id)sender;
- (IBAction)phoneNumberButtonTapped:(id)sender;


@end

@implementation JSFirstSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureBorders];
    [self configureButtons];
    [self configureCoreDataAndVenmo];
    [self createCharge];
    [self configureTableView];
    // Do any additional setup after loading the view.
}

- (void)configureButtons{
    
    self.backButton.imageInsets = UIEdgeInsetsMake(10,0,10,20);
}

- (void)configureGradients{
    
}

- (void)configureBorders{

    self.addressBookButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.addressBookButton.layer.borderWidth    = 1;
    self.addressBookButton.layer.cornerRadius   = 8;
    self.addressBookButton.clipsToBounds        = YES;
    
    self.phoneNumberButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.phoneNumberButton.layer.borderWidth    = 1;
    self.phoneNumberButton.layer.cornerRadius   = 8;;
    self.phoneNumberButton.clipsToBounds        = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCoreDataAndVenmo{
    
    self.dataStore      = [JSCoreData sharedDataStore];
    self.dataStore.inputPhoneNumberArray = [[NSMutableArray alloc]init];
    self.venmoAPIClient = [JSVenmoAPIClient sharedInstance];
    self.contactArray   = [[NSMutableArray alloc]init];
}

- (void)createCharge{
    
    JSCharge *charge = [NSEntityDescription insertNewObjectForEntityForName:@"JSCharge" inManagedObjectContext:self.dataStore.managedObjectContext];
    self.dataStore.currentCharge = charge;
}

#pragma mark - Table View

- (void)configureTableView{
    
    self.contactTableView.delegate      = self;
    self.contactTableView.dataSource    = self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 86;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    return self.dataStore.currentCharge.friend.count;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Alert View

- (void)presentPhoneNumberAlertView{
    
    //CREATE ALERT
    UIAlertController *getPhoneNumberAlert = [UIAlertController alertControllerWithTitle:@"enter a Venmo-connected phone number" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [getPhoneNumberAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    
    //CREATE OK ACTION
    UIAlertAction *okAlert = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        for (UITextField *textField in getPhoneNumberAlert.textFields) {
            
            JSFriend *friend    = [NSEntityDescription insertNewObjectForEntityForName:@"JSFriend" inManagedObjectContext:self.dataStore.managedObjectContext];
            
            friend.phoneNumber  = textField.text;
            
            [self.dataStore.currentCharge addFriendObject:friend];
        }
        [self.dataStore saveContext];
        
    }];
    
    [getPhoneNumberAlert addAction:okAlert];
    
    
    //CREATE ENTER ANOTHER PHONE NUMBER ACTION
//    UIAlertAction *enterAnotherPhoneNumber = [UIAlertAction actionWithTitle:@"Enter another phone number" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    
//        [getPhoneNumberAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
//            textField.keyboardType = UIKeyboardTypeNumberPad;
//        }];
//    }];
//         
//    [getPhoneNumberAlert addAction:enterAnotherPhoneNumber];
    
    [self presentViewController:getPhoneNumberAlert animated:YES completion:nil];
    
    
    
    
    //CREATE CANCEL ACTION
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [getPhoneNumberAlert addAction:cancelAlert];
}


#pragma mark - Contact Picker Delegate
- (void)presentPeoplePicker{
    
    CNContactPickerViewController *picker   = [[CNContactPickerViewController alloc] init];
    picker.delegate                         = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(nonnull NSArray<CNContact *> *)contacts{
    

    //for each contact in contact, go through and create a person object for and attatch it to the current bargaing
    
    
    for (CNContact *eachContact in contacts) {
        
        JSFriend *friend    = [NSEntityDescription insertNewObjectForEntityForName:@"JSFriend" inManagedObjectContext:self.dataStore.managedObjectContext];
        
        friend.displayName  = [NSString stringWithFormat:@"%@ %@", eachContact.givenName, eachContact.familyName];
        friend.lastName     = eachContact.familyName;
        friend.phoneNumber  = [JSVenmoAPIClient returnPhoneNumberStringfromArray:eachContact.phoneNumbers ];
        
        [self.dataStore.currentCharge addFriendObject:friend];

    }
    
    [self.dataStore saveContext];

}


#pragma mark - Actions

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
}

- (IBAction)includeSelfSwitchChanged:(id)sender {
}

- (IBAction)addressBookButtonTapped:(id)sender {
    [self presentPeoplePicker];
}

- (IBAction)phoneNumberButtonTapped:(id)sender {
    [self presentPhoneNumberAlertView];
}
@end
