//
//  JSPhoneTableViewCell.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 10/22/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSPhoneTableViewCell.h"

@implementation JSPhoneTableViewCell

- (void)awakeFromNib {

    [self setBorderAroundButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setBorderAroundButton{
    
//    self.deletePhoneNumberButton.layer.cornerRadius = 8;
//    self.deletePhoneNumberButton.layer.borderWidth  = 1;
//    self.deletePhoneNumberButton.layer.borderColor  = [[UIColor whiteColor]CGColor];
//    self.deletePhoneNumberButton.clipsToBounds      = YES;
    
    self.deletePhoneNumberButton.contentEdgeInsets = UIEdgeInsetsMake(5,5,5,5);
    
    self.borderView.layer.cornerRadius = 8;
    self.borderView.layer.borderWidth  = 1;
    self.borderView.layer.borderColor  = [[UIColor whiteColor]CGColor];
    self.borderView.clipsToBounds      = YES;
    
}

- (IBAction)didTapDeletePhoneNumberButton:(id)sender {

}

@end
