//
//  ACINumberInterval.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACINumberInterval.h"

@implementation ACINumberInterval

- (instancetype)initWithLowerBound:(NSDecimalNumber *)lowerBound upperBound:(NSDecimalNumber *)upperBound {
    self = [super init];
    if (self) {
        self.lowerBound = lowerBound;
        self.upperBound = upperBound;
    }
    return self;
}

- (BOOL)contains:(NSNumber *)number {
    return NO;
}

- (BOOL)isGreaterThanUpperBound:(NSNumber *)number {
    return YES;
}

@end
