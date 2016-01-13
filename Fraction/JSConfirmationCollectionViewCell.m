//
//  JSConfirmationCollectionViewCell.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 1/12/16.
//  Copyright © 2016 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "JSConfirmationCollectionViewCell.h"
#import "JSConstants.h"

@implementation JSConfirmationCollectionViewCell

-(void)awakeFromNib{
    
    [self configureCell];
}


-(void)configureCell{
    
    self.contactLabel.layer.borderColor   = [[UIColor colorWithWhite:1 alpha:1]CGColor];
    self.contactLabel.layer.borderWidth   = BORDER_WIDTH;
    self.contactLabel.layer.cornerRadius  = CORNER_RADIUS;
    self.contactLabel.clipsToBounds       = YES;
    self.contactLabel.backgroundColor     = [UIColor clearColor];
    
    self.amountLabel.layer.borderColor   = [[UIColor colorWithWhite:1 alpha:1]CGColor];
    self.amountLabel.layer.borderWidth   = BORDER_WIDTH;
    self.amountLabel.layer.cornerRadius  = CORNER_RADIUS;
    self.amountLabel.clipsToBounds       = YES;
    self.amountLabel.backgroundColor     = [UIColor clearColor];
    
    self.noteTextView.layer.borderColor   = [[UIColor colorWithWhite:1 alpha:1]CGColor];
    self.noteTextView.layer.borderWidth   = BORDER_WIDTH;
    self.noteTextView.layer.cornerRadius  = CORNER_RADIUS;
    self.noteTextView.clipsToBounds       = YES;
    self.noteTextView.backgroundColor     = [UIColor clearColor];
    
    
    self.actionButton.layer.borderColor   = [[UIColor clearColor]CGColor];
    self.actionButton.layer.borderWidth   = BORDER_WIDTH;
    self.actionButton.layer.cornerRadius  = CORNER_RADIUS;
    self.actionButton.clipsToBounds       = YES;
    self.actionButton.backgroundColor     = [UIColor clearColor];

}

@end
