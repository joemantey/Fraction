//
//  NSString+Formatting.m
//  Fraction
//
//  Created by Joseph Smalls-Mantey on 12/23/15.
//  Copyright © 2015 Yosimite Labs | Joseph Smalls-Mantey. All rights reserved.
//

#import "NSString+Formatting.h"

@implementation NSString (Formatting)


+(NSString*)formatNumbers:(float )inputFloat{
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode: NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:[NSNumber numberWithFloat:inputFloat ]];
    NSString *returnString = [NSString stringWithFormat:@"$ %@", numberString];
    
    return returnString;
}

@end
