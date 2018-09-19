//
//  ACINumberClosedInterval.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACINumberClosedInterval.h"

@implementation ACINumberClosedInterval

- (BOOL)contains:(NSNumber *)number {
    if (([number compare:self.lowerBound] == NSOrderedDescending || [number compare:self.lowerBound] == NSOrderedSame)
        && ([number compare:self.upperBound] == NSOrderedAscending || [number compare:self.upperBound] == NSOrderedSame)) {
        return YES;
    }
    return NO;
}

- (BOOL)isGreaterThanUpperBound:(NSNumber *)number {
    if ([number compare:self.upperBound] == NSOrderedAscending || [number compare:self.upperBound] == NSOrderedSame) {
        return NO;
    }
    return YES;
}

@end
