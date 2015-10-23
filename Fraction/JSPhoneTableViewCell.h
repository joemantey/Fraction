//
//  JSPhoneTableViewCell.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/22/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSPhoneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *deletePhoneNumberButton;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *borderView;



- (IBAction)didTapDeletePhoneNumberButton:(id)sender;

@end
