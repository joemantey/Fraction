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

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIView *totalBackgroundView;
@property (weak, nonatomic) IBOutlet UITextField *totalTextField;
@property (weak, nonatomic) IBOutlet UITextView *notesTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *privacySegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;

- (IBAction)amountTextValueChanged:(id)sender;
- (IBAction)didTapBackButton:(id)sender;
- (IBAction)segmentedControlValueChanged:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;


@end

@implementation JSConfirmSplitViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self configureCoreData];
    [self configureNavigationBar];
    [self configureSlider];
    [self setBackgroundColor];
    [self setOutlines];
    [self addGestureRecognizer];
    [self checkTextView];
    
    
    self.notesTextField.delegate = self;

}

- (void)configureCoreData{
    self.dataStore              = [JSCoreData sharedDataStore];
    
    if (self.dataStore.currentCharge.note) {
        self.notesTextField.text = self.dataStore.currentCharge.note;
    }
    
    if (self.dataStore.currentCharge.audience) {
        self.privacySegmentedControl.selectedSegmentIndex = self.dataStore.currentCharge.audience.integerValue;
    }
    
    [self configureAmountDisplay];
    
}

-(void)configureAmountDisplay{
    
    if (self.dataStore.currentCharge.amount) {
       
        self.totalTextField.text = [NSString formatNumbersToDollarString:self.dataStore.currentCharge.amount.floatValue/self.dataStore.currentCharge.friend.count];
    }else{
        self.totalTextField.text = [NSString formatNumbersToDollarString:0];
    }
   
}


- (void)configureNavigationBar{
    
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
    
 self.totalBackgroundView.layer.cornerRadius = CORNER_RADIUS;
    self.totalBackgroundView.layer.borderWidth  = BORDER_WIDTH;
    self.totalBackgroundView.layer.borderColor  = [[UIColor whiteColor]CGColor];
    self.totalBackgroundView.clipsToBounds      = YES;
    
    self.amountTextField.layer.cornerRadius     = CORNER_RADIUS;
    self.amountTextField.layer.borderWidth      = BORDER_WIDTH;
    self.amountTextField.layer.borderColor      = [[UIColor whiteColor]CGColor];
    self.amountTextField.clipsToBounds          = YES;
    
    self.notesTextField.layer.cornerRadius      = CORNER_RADIUS;
    self.notesTextField.layer.borderWidth       = BORDER_WIDTH;
    self.notesTextField.layer.borderColor       = [[UIColor whiteColor]CGColor];
    self.notesTextField.clipsToBounds           = YES;
    
    self.nextButton.layer.cornerRadius          = CORNER_RADIUS;
    self.nextButton.layer.borderWidth           = BORDER_WIDTH;
    self.nextButton.layer.borderColor           = [[UIColor whiteColor]CGColor];
    self.nextButton.clipsToBounds               = YES;
    self.nextButton.hidden                      = YES;
}


- (void)checkTextView{
    
    if (self.notesTextField.text.length > 0 && self.amountTextField.text.length >0) {
        
        self.nextButton.hidden      = NO;
        
        [self.dataStore saveContext];
    }else{
        
        self.nextButton.hidden      = YES;
        self.dataStore.noteString   = self.notesTextField.text;
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


#pragma mark - Tax Slider

-(void)configureSlider{
    
    self.tipSlider.value = 0;
    [self updateTipLabel];
    
}

-(void)updateTipLabel{
    
    NSInteger taxPercentage     = self.tipSlider.value * 100;
    self.tipLabel.text    = [NSString stringWithFormat:@"%ld%%", (long)taxPercentage];
    [self updateAmounts];
    
}

#pragma mark - Amount Text Field

- (void)updateAmounts{
    
    if (self.amountTextField.text.floatValue > 0) {
        
        CGFloat amount = self.amountTextField.text.floatValue;
        CGFloat count  = self.dataStore.currentCharge.friend.count;
        
        if (self.dataStore.currentCharge.selfIncluded) {
            count =  count+1;
        }
        
        CGFloat tax    = self.tipSlider.value*amount;
        
        self.dataStore.currentCharge.amount = [NSNumber numberWithFloat:amount];
        [self.dataStore saveContext];
        
        self.totalTextField.text = [NSString formatNumbersToDollarString:((amount+tax)/count)];
    }
}


- (IBAction)amountTextValueChanged:(id)sender {

    [self updateAmounts];
}

#pragma mark - Note Text View

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


#pragma mark - Actions



- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)segmentedControlValueChanged:(id)sender {
    
    self.dataStore.privacyPickerIndex = self.privacySegmentedControl.selectedSegmentIndex;
}

- (IBAction)sliderValueChanged:(id)sender {
    
    [self updateTipLabel];

}
@end
