//
//  ACINumberLowerOpenInterval.m
//  ACITextFieldValidator
//
//  Created by Carya on 2018/9/11.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import "ACINumberLowerOpenInterval.h"

@implementation ACINumberLowerOpenInterval

- (BOOL)contains:(NSNumber *)number {
    if (([number compare:self.lowerBound] == NSOrderedDescending)
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
