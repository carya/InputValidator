//
//  ACINumericInputValidator.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/1.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACINumericInputValidator.h"
#import "ACIInputValidateError.h"

@interface ACINumericInputValidator ()

@property (nonatomic, strong) NSCharacterSet *allowCharacterSet;
@property (nonatomic, strong) NSDecimalNumber *zeroDigit;

@end

@implementation ACINumericInputValidator

- (BOOL)validateInput:(UITextField *)textField
    charactersInRange:(NSRange)range
    replacementString:(NSString *)string
                error:(NSError **)error {
    
    // 当前输入金额(尾部增删、粘贴字符或者插入字符)
    NSMutableString *currentString = [NSMutableString stringWithString:textField.text];
    NSMutableString *resultStr = [NSMutableString stringWithString:currentString];
    if ([string length] == 0) { // 删
        return YES;
    } else { // 增
        [resultStr insertString:string atIndex:range.location];
    }
    
    if (![self isAllDecimalDigit:string]) {
        [self errorWithErrorCode:ACIInputValidateErrorCharInvalid Desc:@"character is not valid, should be '0123456789'" error:error];
        return NO;
    }
    
    if (![self.interval contains:self.zeroDigit]) { /**< 区间内不包含数字0 */
        if ([string hasPrefix:@"0"] && range.location == 0) { /** 首位数字不能是0 */
            [self errorWithErrorCode:ACIInputValidateErrorPrefixZeroDigitExceedingOne Desc:@"it is integer, should not contains zero digit prefix" error:error];
            return NO;
        }
    }

    if ([self isGreaterThanMaxValue:resultStr]) {
        [self errorWithErrorCode:ACIInputValidateErrorGreaterThanMaxValue Desc:@"input is greater than max value" error:error];
        return NO;
    }
    
    return YES;
}

- (BOOL)validateEndEditingInput:(UITextField *)textField error:(NSError **)error {
    if (![self isContainsInInterval:textField.text]) {
        [self errorWithErrorCode:ACIInputValidateErrorNotLiesWithinInterval Desc:@"input is not lies within interval" error:error];
        return NO;
    }
    
    return YES;
}

#pragma mark - private methods

- (BOOL)isAllDecimalDigit:(NSString *)string {
    NSCharacterSet *inputStrSet = [NSCharacterSet characterSetWithCharactersInString:string];
    if ([self.allowCharacterSet isSupersetOfSet:inputStrSet]) { /** 合法字符串 */
        return YES;
    }
    return NO;
}

/**
 判断数字是否小于等于最大值 maxValue
 
 @param resultStr 数字字符串
 @return 如果resultStr数字小于等于maxValue，则返回NO，否则返回YES
 */
- (BOOL)isGreaterThanMaxValue:(NSString *)resultStr {
    NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithString:resultStr];
    return [self.interval isGreaterThanUpperBound:result];
}

- (BOOL)isContainsInInterval:(NSString *)resultStr {
    NSDecimalNumber *result = [NSDecimalNumber decimalNumberWithString:resultStr];
    return [self.interval contains:result];
}

- (void)errorWithErrorCode:(ACIInputValidateErrorCode)code Desc:(NSString *)desc error:(NSError **)error {
    if (error) {
        *error = [NSError errorWithDomain:kTextFieldInputValidationErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:desc}];
    }
}

#pragma mark - getter & setter

- (NSCharacterSet *)allowCharacterSet {
    if (!_allowCharacterSet) {
        _allowCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    }
    return _allowCharacterSet;
}

- (NSDecimalNumber *)zeroDigit {
    if (!_zeroDigit) {
        _zeroDigit = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return _zeroDigit;
}

@end
