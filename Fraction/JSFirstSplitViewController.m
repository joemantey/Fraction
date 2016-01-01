//
//  JSFirstSplitViewController.m
//  Fraction
//
//  Created by Norma Smalls-Mantey on 12/30/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

/*
 
 
Formatting: 
 
-create custom cells in IB
-create background class for cells
-method for creating white borders around cells
 
 
Process:
 
-method create new version of charge
-method to attatching contacts to it (person class)
-wipe and reattach contacts to the charge everytime it is changes
-method to make sure before segue you have evrything
-methods for pop for entering phone number with choice to enter another
-method to delete contact from tableview and charge
 */


#import "JSFirstSplitViewController.h"
#import "JSCoreData.h"
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
    [self setUpCoreDataAndVenmo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpCoreDataAndVenmo{
    
    self.dataStore = [JSCoreData sharedDataStore];
    self.dataStore.inputPhoneNumberArray = [[NSMutableArray alloc]init];
    self.venmoAPIClient = [JSVenmoAPIClient sharedInstance];
}

#pragma mark - Table View



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark CNContactPicker Delegate
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
    
    
    //method
    NSLog(@"%@", self.contactArray);
    
    int counter = 0;
    for (CNContact *eachContact in self.contactArray) {
        
        if (counter == 0) {
            
            NSString *nameString    = [NSString stringWithFormat:@"%@ %@", eachContact.givenName, eachContact.familyName];
            self.contactString      = [NSMutableString stringWithFormat:@"%@", nameString];
            
        }else{
            
            NSString *nameString    = [NSString stringWithFormat:@", %@ %@", eachContact.givenName, eachContact.familyName];
            self.contactString      = [NSMutableString stringWithFormat:@"%@%@", self.contactString, nameString];
        }
        
        counter++;
    }
}


#pragma mark - Actions

- (IBAction)backButtonTapped:(id)sender {
}

- (IBAction)nextButtonTapped:(id)sender {
}

- (IBAction)includeSelfSwitchChanged:(id)sender {
}

- (IBAction)addressBookButtonTapped:(id)sender {
}

- (IBAction)phoneNumberButtonTapped:(id)sender {
}
@end
