//
//  JSConfirmSplitViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/27/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSConfirmSplitViewController.h"
#import "JSCoreData.h"

#import "UIColor+Colors.h"
#import "NSString+Formatting.h"

@interface JSConfirmSplitViewController () <UITextViewDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;

@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegmentedControl;
@property (weak, nonatomic) IBOutlet UITextView *notesTextField;
@property (weak, nonatomic) IBOutlet UIButton *completeTransactionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIView *totalBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *taxTextField;
@property (weak, nonatomic) IBOutlet UITextField *totalTextField;

- (IBAction)didTapCompletTransactionButton:(id)sender;
- (IBAction)didTapBackButton:(id)sender;
- (IBAction)segmentedControlValueChanged:(id)sender;


@end

@implementation JSConfirmSplitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpCoreData];
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setOutlines];
    [self addGestureRecognizer];
    [self checkTextView];
    
    self.notesTextField.delegate = self;

}

- (void)setUpCoreData{
    self.dataStore              = [JSCoreData sharedDataStore];
    self.notesTextField.text    = self.dataStore.noteString;
    
    self.privacySegmentedControl.selectedSegmentIndex = self.dataStore.privacyPickerIndex;
    [self setUpAmountDisplay];
    
}

-(void)setUpAmountDisplay{
    
    self.totalTextField.text = [NSString formatNumbers:self.dataStore.currentPayCharge.amount.floatValue/self.dataStore.currentPayCharge.payChargeToPerson.count];
}


- (void)clearNavigationBar{
    
    self.navigationItem.leftBarButtonItem.imageInsets   = UIEdgeInsetsMake(12, 0, 12, 24);
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor      = [UIColor clearColor];
}


- (void)setBackgroundColor{
    
    UIColor *startColor         = [UIColor greenLight];
    UIColor *endColor           = [UIColor greenLight];
    CAGradientLayer*gradient    = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
}

- (void)setOutlines{
    
    self.notesTextField.layer.cornerRadius  = 8;
    self.notesTextField.layer.borderWidth   = 1;
    self.notesTextField.layer.borderColor   = [[UIColor whiteColor]CGColor];
    self.notesTextField.clipsToBounds       = YES;
    
    self.totalBackgroundView.layer.cornerRadius  = 8;
    self.totalBackgroundView.layer.borderWidth   = 1;
    self.totalBackgroundView.layer.borderColor   = [[UIColor whiteColor]CGColor];
    self.totalBackgroundView.clipsToBounds       = YES;
    
    self.completeTransactionButton.layer.cornerRadius       = 8;
    self.completeTransactionButton.layer.borderWidth        = 1;
    self.completeTransactionButton.layer.borderColor        = [[UIColor clearColor]CGColor];
    self.completeTransactionButton.clipsToBounds            = YES;
    self.completeTransactionButton.userInteractionEnabled   = NO;
  
}

- (void)checkTextView{
    
    if (self.notesTextField.text.length > 0) {
        
        [self.completeTransactionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completeTransactionButton.layer.borderColor          =  [[UIColor whiteColor]CGColor];
        self.completeTransactionButton.userInteractionEnabled   = YES;
        self.dataStore.noteString                               = self.notesTextField.text;
        [self.completeTransactionButton setTitle:@"next: confirm splits" forState:UIControlStateNormal];

        
        [self.dataStore saveContext];
    }else{
        
        [self.completeTransactionButton setTitleColor:[UIColor colorWithWhite:1 alpha:0.75] forState:UIControlStateNormal];
        [self.completeTransactionButton setTitle:@"please complete all fields" forState:UIControlStateNormal];
        self.completeTransactionButton.backgroundColor          =  [UIColor clearColor];
        self.completeTransactionButton.userInteractionEnabled   = NO;
        self.dataStore.noteString                               = self.notesTextField.text;
        
        [self.dataStore saveContext];
    }
    
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [self dismissKeyboard];
        
            } else {
        NSLog(@"Other pressed");
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    [self checkTextView];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.dataStore saveContext];
    
    self.dataStore.noteString                         = self.notesTextField.text;
    
    self.dataStore.privacyPickerIndex = self.privacySegmentedControl.selectedSegmentIndex;
 
    [self checkTextView];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)didTapCompletTransactionButton:(id)sender {
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentedControlValueChanged:(id)sender {
    
    self.dataStore.privacyPickerIndex = self.privacySegmentedControl.selectedSegmentIndex;
}
@end
