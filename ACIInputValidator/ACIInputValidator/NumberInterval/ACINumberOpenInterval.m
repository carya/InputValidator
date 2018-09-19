//
//  ACINumberOpenInterval.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACINumberOpenInterval.h"

@implementation ACINumberOpenInterval

- (BOOL)contains:(NSNumber *)number {
    if (([number compare:self.lowerBound] == NSOrderedDescending)
        && ([number compare:self.upperBound] == NSOrderedAscending)) {
        return YES;
    }
    return NO;
}

- (BOOL)isGreaterThanUpperBound:(NSNumber *)number {
    if ([number compare:self.upperBound] == NSOrderedAscending) {
        return NO;
    }
    return YES;
}

@end
