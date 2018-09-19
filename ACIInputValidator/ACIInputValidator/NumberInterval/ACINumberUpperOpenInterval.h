//
//  ACINumberUpperOpenInterval.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//
//  A half-open IntervalType, which contains its start but not its end. Can represent an empty interval. [1,10)

#import <Foundation/Foundation.h>
#import "ACINumberInterval.h"

@interface ACINumberUpperOpenInterval : ACINumberInterval

- (BOOL)contains:(NSNumber *)number;

@end
