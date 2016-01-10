//
//  JSAdjustSplitViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/23/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSAdjustSplitViewController.h"
#import "JSSplitTableViewCell.h"

#import "JSCoreData.h"
#import "JSVenPerson.h"
#import "JSFriend.h"
#import "JSVenmoAPIClient.h"

#import "UIColor+Colors.h"



@import Contacts;

@interface JSAdjustSplitViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;
@property (strong, nonatomic) JSVenmoAPIClient  *venmoAPIClient;
@property (strong, nonatomic) NSMutableArray    *friendArray;

@property (weak, nonatomic) IBOutlet UIView         *blurView;
@property (weak, nonatomic) IBOutlet UIView         *backgroundContainer;
@property (weak, nonatomic) IBOutlet UIView         *buttonContainer;
@property (weak, nonatomic) IBOutlet UIView         *amountRemainingContainer;
@property (weak, nonatomic) IBOutlet UIView         *buttonBlurView;
@property (weak, nonatomic) IBOutlet UITextField    *amountRemainingTextView;
@property (weak, nonatomic) IBOutlet UITextField    *perAmountRemainingTextView;
@property (weak, nonatomic) IBOutlet UIButton       *completeTransactionButton;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;

- (IBAction)didTapBackButton:(id)sender;
- (IBAction)didTapCompleteTransactionButton:(id)sender;


@end

@implementation JSAdjustSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureCoreData];
    [self clearNavigationBar];
    [self setOutlines];
    [self setDealText];
    
    self.tableView.delegate     = self;
    self.tableView.dataSource   = self;
    [self.tableView setContentInset:UIEdgeInsetsMake(-20,0, self.view.frame.size.height*.17,0)];
    
    [self setBackgroundColor];

    // Do any additional setup after loading the view.
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCoreData{
    
    self.dataStore      = [JSCoreData sharedDataStore];
    self.friendArray    = [[NSMutableArray alloc]initWithArray: [self.dataStore.currentCharge.friend allObjects]];
    self.venmoAPIClient = [JSVenmoAPIClient sharedInstance];

    
    if (self.dataStore.currentCharge.selfIncluded) {
        
        [self.friendArray insertObject:self.dataStore.currentCharge.me atIndex:0];
    }
    
    [self.venmoAPIClient splitAmount];
    [self.dataStore saveContext];

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
    
    UIColor *startColor         = [UIColor greenLight];
    UIColor *endColor           = [UIColor greenLight];
    
    CAGradientLayer *gradient   = [CAGradientLayer layer];
    gradient.frame              =  self.view.bounds;
    gradient.colors             = [NSArray arrayWithObjects:(id)[startColor CGColor], (id)[endColor CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    UIColor *startColor2         = [UIColor greenLight];
    UIColor *endColor2           = [UIColor greenClear];
    
    
    CAGradientLayer *gradient2   = [CAGradientLayer layer];
    gradient2.frame              =  self.blurView.bounds;
    gradient2.colors             = [NSArray arrayWithObjects:(id)[startColor2 CGColor], (id)[endColor2 CGColor], nil];
    [self.blurView.layer insertSublayer:gradient2 atIndex:0];
    
    CAGradientLayer *gradient3   = [CAGradientLayer layer];
    gradient3.frame              =  self.buttonBlurView.bounds;
    gradient3.colors             = [NSArray arrayWithObjects:(id)[endColor2 CGColor], (id)[startColor2 CGColor], nil];
    [self.buttonBlurView.layer insertSublayer:gradient3 atIndex:0];
    
    
    self.buttonContainer.backgroundColor = [UIColor greenLight];
}


- (void)setOutlines{
    
    self.backgroundContainer.layer.cornerRadius         = 8;
    self.backgroundContainer.layer.borderWidth          = 1;
    self.backgroundContainer.layer.borderColor          = [[UIColor whiteColor]CGColor];
    self.backgroundContainer.clipsToBounds              = YES;
    
    self.amountRemainingContainer.layer.borderWidth     = 1;
    self.amountRemainingContainer.layer.borderColor     = [[UIColor whiteColor]CGColor];
    self.amountRemainingContainer.clipsToBounds         = YES;
    
    self.completeTransactionButton.layer.cornerRadius   = 8;
    self.completeTransactionButton.layer.borderWidth    = 1;
    self.completeTransactionButton.layer.borderColor    = [[UIColor whiteColor]CGColor];
    self.completeTransactionButton.clipsToBounds        = YES;
}

- (void)setDealText{
    
    self.amountRemainingTextView.text       = [NSString stringWithFormat:@"$ %.f", self.dataStore.currentCharge.amountLeft.floatValue];
    self.perAmountRemainingTextView.text    = [NSString stringWithFormat:@"$%.f", (self.dataStore.currentCharge.amountLeft.floatValue/self.friendArray.count)];
}


#pragma mark - Tableview Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.friendArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier    = @"splitCell";
    JSSplitTableViewCell *cell  = (JSSplitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell                    = [[JSSplitTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    JSFriend *friend            = [self.friendArray  objectAtIndex: indexPath.row];
    cell.cellFriend             = friend;
    
    NSLog(@"PLEDGED AMOUNT %@", friend.pledgedAmount);
//    cell.percentTextView.text   = [NSString stringWithFormat:@"%.f%%", friend.shareOfAmount.floatValue*100];
    cell.shareTextView.text     = [NSString stringWithFormat:@"$%ld", friend.pledgedAmount.integerValue];
    cell.contactTextView.text   = friend.displayName;
    cell.slider.value           = friend.pledgedAmount.floatValue/self.dataStore.currentCharge.amount.floatValue;
    cell.slider.tag             = indexPath.row;
    cell.slider.maximumValue    = 1;
    cell.slider.minimumValue    = 0;
    cell.slider.continuous      = YES;
    
    [cell.slider addTarget:self
                    action:@selector(sliderValueChangedwithSender:)
          forControlEvents:UIControlEventValueChanged];
    
    
    return cell;
    
}

-(void)sliderValueChangedwithSender:(UISlider *)sender{
    
    JSFriend *friend      = self.friendArray[sender.tag];
    
    CGFloat sliderValue         = sender.value;
    
    friend.pledgedAmount = [NSNumber numberWithFloat:(self.dataStore.currentCharge.amount.floatValue * sliderValue)];
    friend.shareOfAmount = [NSNumber numberWithFloat:(friend.pledgedAmount.floatValue/self.dataStore.currentCharge.amount.floatValue)];
    
    [self.dataStore saveContext];
    [self.venmoAPIClient refreshSplit];
    [self.tableView reloadData];
    [self setDealText];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.dataStore saveContext];
    }];
    
}

- (IBAction)didTapCompleteTransactionButton:(id)sender {
    
    
}
@end
