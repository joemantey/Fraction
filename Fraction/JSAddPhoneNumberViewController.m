//
//  JSAddPhoneNumberViewController.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/22/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSAddPhoneNumberViewController.h"
#import "JSPhoneTableViewCell.h"

#import "JSCoreData.h"

@interface JSAddPhoneNumberViewController () <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) JSCoreData        *dataStore;
@property (nonatomic) BOOL                      phoneNumberIsValid;

@property (weak, nonatomic) IBOutlet UITextField *addPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *addPhoneNumberButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)didTapAddPhoneNumberButton:(id)sender;
- (IBAction)didTapBackButton:(id)sender;

@end

@implementation JSAddPhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.dataStore = [JSCoreData sharedDataStore];
    [self clearNavigationBar];
    [self setBackgroundColor];
    [self setUpBorders];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

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


- (void)setUpBorders{
    
  
    self.addPhoneNumberTextField.layer.cornerRadius = 8;
    self.addPhoneNumberTextField.layer.borderWidth  = 1;
    self.addPhoneNumberTextField.layer.borderColor  = [[UIColor whiteColor]CGColor];
    self.addPhoneNumberTextField.clipsToBounds      = YES;
    
//    self.addPhoneNumberButton.layer.cornerRadius    = 8;
//    self.addPhoneNumberButton.layer.borderWidth     = 1;
//    self.addPhoneNumberButton.layer.borderColor     = [[UIColor whiteColor]CGColor];
//    self.addPhoneNumberButton.clipsToBounds         = YES;
//    
//    self.tableView.layer.cornerRadius               = 8;
//    self.tableView.layer.borderWidth                = 1;
//    self.tableView.layer.borderColor                = [[UIColor whiteColor]CGColor];
//    self.tableView.clipsToBounds                    = YES;
    
    
}


#pragma mark - Text Field Methods


- (void)addPhoneNumberToPhoneNumberArray{
    
    
  
    NSString *phoneNumber = self.addPhoneNumberTextField.text;
    
    if ([self checkIfPhoneNumberValid]) {
        
        if (!self.dataStore.inputPhoneNumberArray) self.dataStore.inputPhoneNumberArray = [[NSMutableArray alloc] init];
        [self.dataStore.inputPhoneNumberArray  addObject:phoneNumber];
        
        [self.dataStore saveContext];
        [self clearTextField];

    }else{
       
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please enter a valid phone number"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [self clearTextField];
    }
    
    [self.view endEditing:YES];
    [self.tableView reloadData];
}

- (void)clearTextField{
    
    self.addPhoneNumberTextField.text = @"";
}

- (BOOL)checkIfPhoneNumberValid{
    
    NSString *phoneNumber = self.addPhoneNumberTextField.text;
    
    if ([phoneNumber length] > 8   ){
        
        self.phoneNumberIsValid = YES;
        return YES;
    }
    else{
        
        self.phoneNumberIsValid = NO;
        return NO;
    }
    
}


#pragma mark TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataStore.inputPhoneNumberArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier    = @"phoneCell";
    JSPhoneTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell                    = [[JSPhoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//        cell.selectionStyle     = UITableViewCellSelectionStyleNone;
    }
    
    cell.phoneNumberLabel.text               = self.dataStore.inputPhoneNumberArray[indexPath.row];
    cell.deletePhoneNumberButton.tag    = indexPath.row;
    [cell.deletePhoneNumberButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}



//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return YES if you want the specified item to be editable.
//    return YES;
//}
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //add code here for when you hit delete
//    }
//}
//     
//     

- (void)deleteButtonClicked:(UIButton *)sender{
    
    [self.dataStore.inputPhoneNumberArray removeObjectAtIndex:sender.tag];
    [self.dataStore saveContext];
    [self.tableView reloadData];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapAddPhoneNumberButton:(id)sender {
    
    [self addPhoneNumberToPhoneNumberArray];
}

- (IBAction)didTapBackButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.dataStore saveContext];
    }];
}
@end
