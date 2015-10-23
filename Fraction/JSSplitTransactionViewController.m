//
//  JSSplitTransactionViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/21/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSSplitTransactionViewController.h"
#import "JSCoreData.h"

@import Contacts;
@import ContactsUI;

@interface JSSplitTransactionViewController () <UIActionSheetDelegate, CNContactPickerDelegate>

@property (nonatomic) BOOL amountTextViewValid;
@property (nonatomic) BOOL contactTextViewValid;

@property (strong, nonatomic) NSMutableString   *contactString;
@property (strong, nonatomic) NSMutableArray    *contactArray;
@property (nonatomic)         NSInteger         contactCount;
@property (nonatomic)         NSInteger         totalEach;
@property (nonatomic)         NSInteger         taxEach;
@property (nonatomic)         NSInteger         tipEach;

@property (strong, nonatomic) JSCoreData        *dataStore;


@property (weak, nonatomic) IBOutlet UITextField    *postSplitAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField    *splitTipTextField;
@property (weak, nonatomic) IBOutlet UITextField    *splitTaxTextField;
@property (weak, nonatomic) IBOutlet UITextField    *contactTextField;
@property (weak, nonatomic) IBOutlet UITextField    *amountTextField;
@property (weak, nonatomic) IBOutlet UIView         *amountTotalBackground;
@property (weak, nonatomic) IBOutlet UIView         *eachAmountBackground;
@property (weak, nonatomic) IBOutlet UIView         *taxAmountBackground;
@property (weak, nonatomic) IBOutlet UISlider       *taxSlider;
@property (weak, nonatomic) IBOutlet UITextField    *taxAmountField;
@property (weak, nonatomic) IBOutlet UIView         *tipAmountBackground;
@property (weak, nonatomic) IBOutlet UISlider       *tipSlider;
@property (weak, nonatomic) IBOutlet UITextField    *tipAmountField;

@property (weak, nonatomic) IBOutlet UIButton       *completeTransactionButton;

- (IBAction)didTapBackButton:(id)sender;
- (IBAction)didTapAddContact:(id)sender;
- (IBAction)didFinishEditingContactTextField:(id)sender;
- (IBAction)didiEndEditingAmount:(id)sender;
- (IBAction)tipSliderValueChanged:(id)sender;
- (IBAction)taxSliderValueChanged:(id)sender;
- (IBAction)didTapCompletetTransaction:(id)sender;

@end

@implementation JSSplitTransactionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setOutlines];
    [self addGestureRecognizer];
    [self setUpSlider];
    [self getTotalEach];
    
    self.splitTaxTextField.text    = [NSString stringWithFormat:@"$%ld", (long)self.taxEach ];
    self.splitTipTextField.text    = [NSString stringWithFormat:@"$%ld", (long)self.tipEach ];
    self.postSplitAmountTextField.text = @"$ --";

}

- (void)viewWillAppear:(BOOL)animated{
    
    [self getTotalEach];
}

- (void)setUpCoreData{
    
    self.dataStore = [JSCoreData sharedDataStore];
    self.dataStore.inputPhoneNumberArray = [[NSMutableArray alloc]init];
    
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
    
    UIColor *startColor         = [UIColor colorWithRed:0.000 green:0.806 blue:0.827 alpha:1.000];
    UIColor *endColor           = [UIColor colorWithRed:0.000 green:0.806 blue:0.827 alpha:1.000];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}


- (void)setOutlines{
    
    self.amountTotalBackground.layer.cornerRadius       = 8;
    self.amountTotalBackground.layer.borderWidth        = 1;
    self.amountTotalBackground.layer.borderColor        = [[UIColor whiteColor]CGColor];
    self.amountTotalBackground.clipsToBounds            = YES;
    
    self.eachAmountBackground.layer.borderWidth         = 1;
    self.eachAmountBackground.layer.borderColor         = [[UIColor whiteColor]CGColor];
    self.eachAmountBackground.clipsToBounds             = YES;
    
    self.tipAmountBackground.layer.borderWidth          = 1;
    self.tipAmountBackground.layer.borderColor          = [[UIColor whiteColor]CGColor];
    self.tipAmountBackground.clipsToBounds              = YES;
    
    self.contactTextField.layer.cornerRadius            = 8;
    self.contactTextField.layer.borderWidth             = 1;
    self.contactTextField.layer.borderColor             = [[UIColor whiteColor]CGColor];
    self.contactTextField.clipsToBounds                 = YES;
    
    self.amountTextField.layer.cornerRadius             = 8;
    self.amountTextField.layer.borderWidth              = 1;
    self.amountTextField.layer.borderColor              = [[UIColor whiteColor]CGColor];
    self.amountTextField.clipsToBounds                  = YES;
    
    self.completeTransactionButton.layer.cornerRadius   = 8;
    self.completeTransactionButton.layer.borderWidth    = 1;
    self.completeTransactionButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.completeTransactionButton.clipsToBounds        = YES;
    [self.completeTransactionButton setTitle:@"Please complete all fields" forState:UIControlStateNormal];
    
  
    self.completeTransactionButton.userInteractionEnabled= YES;
}


- (void)addGestureRecognizer{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}


- (void)dismissKeyboard{
  
    [self.view endEditing:YES];
}

#pragma mark Math Methods

- (void)getContactCount{
    
    if (!self.contactCount) {
        self.contactCount = 0;
    }
    self.contactCount = self.dataStore.inputPhoneNumberArray.count + self.contactArray.count;
    
}


- (void)getTotalEach{
    [self getContactCount];
    
    if (self.amountTextField.text.floatValue > 0 && self.contactCount > 0) {
        [self getTipEach];
        [self getTaxEach];
        [self getContactCount];
        
        self.totalEach                      = (self.amountTextField.text.floatValue / self.contactCount) + self.taxEach + self.tipEach;
        self.postSplitAmountTextField.text  = [NSString stringWithFormat:@"$%.2ld", (long)self.totalEach ];
        
        self.completeTransactionButton.backgroundColor      = [UIColor clearColor];
        [self.completeTransactionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.completeTransactionButton setTitle:@"Next: Adjust shares" forState:UIControlStateNormal];
         self.completeTransactionButton.userInteractionEnabled= YES;
    }
   

}


- (void)getTaxEach{
    
    self.taxEach                = self.taxSlider.value * self.amountTextField.text.floatValue;
    self.splitTaxTextField.text    = [NSString stringWithFormat:@"$%ld", (long)self.taxEach ];
}


- (void)getTipEach{
    
    self.tipEach                = self.tipSlider.value * self.amountTextField.text.floatValue;
    self.splitTipTextField.text    = [NSString stringWithFormat:@"$%ld", (long)self.tipEach ];
}

#pragma mark UISlider Methods

- (void)setUpSlider{
    
    self.tipSlider.value        = 0;
    NSInteger tipPercentage     = self.tipSlider.value * 100;
    self.tipAmountField.text    = [NSString stringWithFormat:@"%ld %%", (long)tipPercentage];
    
    self.taxSlider.value        = 0;
    NSInteger taxPercentage     = self.taxSlider.value * 100;
    self.taxAmountField.text    = [NSString stringWithFormat:@"%ld %%", (long)taxPercentage];
}



#pragma mark UIActionSheet

- (void)presentActionController{
    
    NSString *alertTitle = @"Please select a method to add contacts";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *addressBook  = [UIAlertAction actionWithTitle:@"Add contact from Address Book"
                                                   style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             
                                                             [self presentPeoplePicker];
//                                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                            }];
    
    UIAlertAction *phoneNumber  = [UIAlertAction actionWithTitle:@"Type in phone number"
                                                            style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
//                                                                [self dismissViewControllerAnimated:YES completion:nil];
                                                             [self performSegueWithIdentifier:@"phoneSegue" sender:nil];
                                                            }];
    
    UIAlertAction *cancel       = [UIAlertAction actionWithTitle:@"Cancel"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action){
//                                                                 [self dismissViewControllerAnimated:YES completion:nil];
                                                             }];
    
    [alertController addAction:addressBook];
    [alertController addAction:phoneNumber];
    [alertController addAction:cancel];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



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
        
        self.contactTextField.text  = self.contactString;
        
        counter++;
    }
}




#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
}



#pragma mark - View Input Methods
- (IBAction)tipSliderValueChanged:(id)sender {
    
    NSInteger tipPercentage     = self.tipSlider.value * 100;
    self.tipAmountField.text    = [NSString stringWithFormat:@"%ld %%", (long)tipPercentage];
    [self getTotalEach];
}

- (IBAction)taxSliderValueChanged:(id)sender {
    
    NSInteger taxPercentage     = self.taxSlider.value * 100;
    self.taxAmountField.text    = [NSString stringWithFormat:@"%ld %%", (long)taxPercentage];
    [self getTotalEach];
}

- (IBAction)didTapCompletetTransaction:(id)sender {
}

- (IBAction)didTapAddContact:(id)sender {
    
    [self presentActionController];
     [self getTotalEach];
}

- (IBAction)didFinishEditingContactTextField:(id)sender {
     [self getTotalEach];
}

- (IBAction)didiEndEditingAmount:(id)sender {
     [self getTotalEach];
}
- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
