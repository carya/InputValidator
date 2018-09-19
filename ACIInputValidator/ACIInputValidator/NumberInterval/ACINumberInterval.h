//
//  ACINumberInterval.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/9.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACINumberInterval : NSObject

@property (nonatomic, strong) NSDecimalNumber *lowerBound;
@property (nonatomic, strong) NSDecimalNumber *upperBound;

- (instancetype)initWithLowerBound:(NSDecimalNumber *)lowerBound upperBound:(NSDecimalNumber *)upperBound;
- (BOOL)contains:(NSNumber *)number;
- (BOOL)isGreaterThanUpperBound:(NSNumber *)number;

@end
