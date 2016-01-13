//
//  JSConfirmationCollectionViewCell.h
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 1/12/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSConfirmationCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UITextField *contactLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;
@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIImageView *noImage;
@property (weak, nonatomic) IBOutlet UIImageView *yesImage;

@end
