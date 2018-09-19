//
//  ACINumberOpenInterval.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//  (1, 10)

#import <Foundation/Foundation.h>
#import "ACINumberInterval.h"

@interface ACINumberOpenInterval : ACINumberInterval

- (BOOL)contains:(NSNumber *)number;

@end
