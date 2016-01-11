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



#warning COLORS HERE https://www.typesupply.com/fonts/timonium

#import "JSFirstSplitViewController.h"
#import "JSSplitContactTableViewCell.h"

#import "JSCoreData.h"
#import "JSCharge.h"
#import "JSFriend.h"
#import "JSVenmoAPIClient.h"

#import "JSConstants.h"
#import "UIColor+Colors.h"
#import "NSString+Formatting.h"
#import "UIView+Shimmer.h"


@interface JSFirstSplitViewController () <UITableViewDelegate, UITableViewDataSource, CNContactPickerDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;
@property (strong, nonatomic) JSVenmoAPIClient  *venmoAPIClient;

@property (nonatomic)         BOOL              contactsAdded;
@property (strong, nonatomic) NSMutableString   *contactString;
@property (strong, nonatomic) NSMutableArray    *contactArray;
@property (nonatomic)         NSInteger         contactCount;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UISwitch *includeSelfSwitch;
@property (weak, nonatomic) IBOutlet UIButton *addressBookButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberButton;
@property (weak, nonatomic) IBOutlet UIView *bottomFadeView;
@property (weak, nonatomic) IBOutlet UIView *topFadeView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

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
    [self configureButtons];
    [self configureNavigationBar];
    [self configureColors];
    [self configureCoreDataAndVenmo];
    [self createCharge];
    [self configureTableView];
    // Do any additional setup after loading the view.
}

- (void)configureButtons{
    
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(12, 0, 12, 24);
    
    self.addressBookButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.addressBookButton.backgroundColor      = [UIColor greenLight];
    self.addressBookButton.layer.borderWidth    = BORDER_WIDTH;
    self.addressBookButton.layer.cornerRadius   = CORNER_RADIUS;
    self.addressBookButton.clipsToBounds        = YES;
    
    self.phoneNumberButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.phoneNumberButton.backgroundColor      = [UIColor greenLight];
    self.phoneNumberButton.layer.borderWidth    = BORDER_WIDTH;
    self.phoneNumberButton.layer.cornerRadius   = CORNER_RADIUS;
    self.phoneNumberButton.clipsToBounds        = YES;
    
    self.nextButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.nextButton.backgroundColor      = [UIColor greenLight];
    self.nextButton.layer.borderWidth    = BORDER_WIDTH;
    self.nextButton.layer.cornerRadius   = CORNER_RADIUS;
    self.nextButton.clipsToBounds        = YES;
    
}

- (void)configureColors{
  
    self.view.backgroundColor = [UIColor greenLight];
    
    CAGradientLayer *topDarkGradient = [CAGradientLayer layer];
    topDarkGradient.frame            =  self.topFadeView.bounds;
    topDarkGradient.colors           = [NSArray arrayWithObjects:(id)[[UIColor greenLight] CGColor], (id)[[UIColor greenClear] CGColor], nil];
    [self.topFadeView.layer insertSublayer:topDarkGradient atIndex:0];
    
    CAGradientLayer *bottomDarkGradient = [CAGradientLayer layer];
    bottomDarkGradient.frame            =  self.topFadeView.bounds;
    bottomDarkGradient.colors           = [NSArray arrayWithObjects:(id)[[UIColor greenClear] CGColor], (id)[[UIColor greenLight] CGColor], nil];
    [self.bottomFadeView.layer insertSublayer:bottomDarkGradient atIndex:0];
    
    self.includeSelfSwitch.onTintColor      = [UIColor whiteColor];
}


- (void)configureNavigationBar{
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor greenLight];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)configureCoreDataAndVenmo{
    
    self.dataStore      = [JSCoreData sharedDataStore];
    self.dataStore.inputPhoneNumberArray = [[NSMutableArray alloc]init];
    self.venmoAPIClient = [JSVenmoAPIClient sharedInstance];
    self.contactArray   = [[NSMutableArray alloc]init];
    for (UIView *subview in self.contactTableView.subviews)
    {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UITableViewWrapperView"])
        {
            subview.frame = CGRectMake(0, 0, self.contactTableView.bounds.size.width, self.contactTableView.bounds.size.height);
        }
    }
}

- (void)createCharge{
    
    JSCharge *charge = [NSEntityDescription insertNewObjectForEntityForName:@"JSCharge" inManagedObjectContext:self.dataStore.managedObjectContext];
    self.dataStore.currentCharge = charge;
    
    JSFriend *friend    = [NSEntityDescription insertNewObjectForEntityForName:@"JSFriend" inManagedObjectContext:self.dataStore.managedObjectContext];
    friend.displayName  = @"Me";
    self.dataStore.currentCharge.me = friend;
}

#pragma mark - Table View

- (void)configureTableView{
    
    self.contactTableView.delegate      = self;
    self.contactTableView.dataSource    = self;
    self.contactTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 72;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
    [self refreshContactArray];
    return self.contactArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier            = @"splitContactCell";
    JSSplitContactTableViewCell *cell   = (JSSplitContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell                    = [[JSSplitContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell.deleteButton addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
    
    JSFriend *friend    = [self.contactArray objectAtIndex:indexPath.row];
   
    cell.contactField.text = friend.displayName;
    cell.contactField.textColor = [UIColor greenLight];
    cell.deleteButton.tintColor = [UIColor greenLight];
    cell.cellOutilineView.backgroundColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];
    
    if ([friend.displayName  isEqual: @"Me"]) {
        cell.deleteButton.tintColor                 = [UIColor clearColor];
        cell.deleteButton.userInteractionEnabled    = NO;
    }
    
    return cell;
}

-(void )deleteRow:(UIButton *)sender{
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.contactTableView];
    NSIndexPath *indexPath = [self.contactTableView indexPathForRowAtPoint:buttonPosition];
    
    if (indexPath != nil)
    {
        JSFriend *thisFriend = self.contactArray[indexPath.row];

        [self.contactTableView beginUpdates];
        [self.dataStore.managedObjectContext deleteObject:thisFriend];

        
        [self.dataStore saveContext];
        [self.contactTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.contactTableView reloadData];
        
        [self.contactTableView endUpdates];
        
    }
    
}

- (void)refreshContactArray{
    
    NSMutableArray *contactArrayBuilder = [[NSMutableArray alloc]initWithArray:self.dataStore.currentCharge.friend.allObjects];
    
    if (self.includeSelfSwitch.on) {
        
        self.dataStore.currentCharge.selfIncluded = [NSNumber numberWithBool:YES];
//        JSFriend *friend    = [NSEntityDescription insertNewObjectForEntityForName:@"JSFriend" inManagedObjectContext:self.dataStore.managedObjectContext];
//        friend.displayName  = @"Me";
        [contactArrayBuilder insertObject:self.dataStore.currentCharge.me atIndex:0];
        [self.dataStore saveContext];
    }else{
        self.dataStore.currentCharge.selfIncluded = [NSNumber numberWithBool:NO];
    }
    
    [self.dataStore saveContext];
    self.contactArray = contactArrayBuilder;
    [self toggleNextButton];
}

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
            friend.displayName  = textField.text;
            
            [self.dataStore.currentCharge addFriendObject:friend];
        }
        [self.dataStore saveContext];
        [self.contactTableView reloadData];

    }];
    
    [getPhoneNumberAlert addAction:okAlert];
    
    [self presentViewController:getPhoneNumberAlert animated:YES completion:nil];
    
    
    
    
    //CREATE CANCEL ACTION
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.contactTableView reloadData];

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
    [self.contactTableView reloadData];

}


#pragma mark - Actions

- (void)toggleNextButton{
    
    BOOL complete =  NO;
    
    if (self.contactArray.count > 0 && !self.includeSelfSwitch.on) {
        complete = YES;
    }else if (self.contactArray.count > 1 && self.includeSelfSwitch.on){
        complete = YES;
    }
    
    if (complete) {
        self.nextButton.hidden = NO;
        self.titleLabel.text = @"Add contacts";

    }else{
        self.nextButton.hidden = YES;
        self.titleLabel.text = @"Next: Enter Details";
    }
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonTapped:(id)sender {
}

- (IBAction)includeSelfSwitchChanged:(id)sender {
    
    [self refreshContactArray];
    [self.contactTableView reloadData];
}

- (IBAction)addressBookButtonTapped:(id)sender {
    [self presentPeoplePicker];
}

- (IBAction)phoneNumberButtonTapped:(id)sender {
    [self presentPhoneNumberAlertView];
}
@end
