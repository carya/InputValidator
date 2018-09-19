//
//  ACINumberClosedInterval.h
//  TextFieldInputValidator
//  A closed IntervalType, which contains both its start and its end. Cannot represent an empty interval.
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//  [1, 10]

#import <Foundation/Foundation.h>
#import "ACINumberInterval.h"

@interface ACINumberClosedInterval : ACINumberInterval

- (BOOL)contains:(NSNumber *)number;

@end
