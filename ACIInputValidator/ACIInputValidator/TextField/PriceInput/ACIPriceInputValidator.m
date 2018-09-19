//
//  ACIPriceInputValidator.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/1.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACIPriceInputValidator.h"
#import "ACINumberOpenInterval.h"
#import "ACINumberClosedInterval.h"
#import "ACINumberUpperOpenInterval.h"
#import "ACIInputValidateError.h"

@interface ACIPriceInputValidator ()

@property (nonatomic, strong) NSCharacterSet *allowCharacterSet;

@end

@implementation ACIPriceInputValidator

- (BOOL)validateInput:(UITextField *)textField
    charactersInRange:(NSRange)range
    replacementString:(NSString *)string
                error:(NSError **)error {
    
    // 当前输入金额(尾部增删、粘贴字符或者插入字符)
    NSString *currentString = textField.text;
    NSMutableString *resultStr = [NSMutableString stringWithString:currentString];
    if ([string length] == 0) { // 删除字符
        return YES;
    } else { // 尾部增加字符，或者是插入字符
        [resultStr insertString:string atIndex:range.location];
    }
    
    if (![self isAllNumberOrDot:string]) {
        [self errorWithErrorCode:ACIInputValidateErrorCharInvalid Desc:@"character is not valid, should be '0123456789.'" error:error];
        return NO;
    }
    
    if ([self isFirstCharacterDecimalPoint:resultStr]) { /** 首位数字不能是小数点 */
        NSString *text = [NSString stringWithFormat:@"0%@", resultStr];
        textField.text = text;
        [self errorWithErrorCode:ACIInputValidateErrorFirstCharDecimalPoint Desc:@"first character should not be a decimal point" error:error];
        return NO;
    }
    
    if ([self hasMoreThanOneDecimalPoint:resultStr]) {
        [self errorWithErrorCode:ACIInputValidateErrorMoreThanOneDecimalPoint Desc:@"should not has more than one decimal point" error:error];
        return NO;
    }
    
    /** 首部最多一个0, 考虑复制一串数字 */
    BOOL isPrefixZeroDigitLessThanTwo = [self makeSurePrefixZeroDigitLessThanTwo:textField resultStr:resultStr];
    if (!isPrefixZeroDigitLessThanTwo) {
        [self errorWithErrorCode:ACIInputValidateErrorPrefixZeroDigitExceedingOne Desc:@"prefix zero digit should not exceed one, if it is integer, should not contains zero digit prefix, if it is decimal, should has only one zero digit prefix" error:error];
        return NO;
    }
    
    if ([self hasMoreThanTwoDecimalDigits:resultStr]) {
        [self errorWithErrorCode:ACIInputValidateErrorMoreThanTwoDecimalDigits Desc:@"the price decimal digits should not exceed two" error:error];
        return NO;
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

/** 首部最多一个0, 考虑复制一串数字 */
- (BOOL)makeSurePrefixZeroDigitLessThanTwo:(UITextField *)textField resultStr:(NSString *)resultStr {
    
    if ([resultStr length] > 1
        && [resultStr hasPrefix:@"0"]) {
        
        NSString *regExpString = @"^(0)+";
        NSRegularExpression *prefixZeroRegularExp = [NSRegularExpression regularExpressionWithPattern:regExpString options:NSRegularExpressionAnchorsMatchLines error:nil];
        NSUInteger matchCount = [prefixZeroRegularExp numberOfMatchesInString:resultStr options:NSMatchingAnchored range:NSMakeRange(0, resultStr.length)];
        
        BOOL isValid = YES;
        NSString *temp = resultStr;
        if (![resultStr containsString:@"."]) { /** 不包含小数点，即整数 */
            if (matchCount >= 1) {
                isValid = NO;
                temp = [resultStr substringFromIndex:matchCount];
            }
            
        } else {
            if (matchCount >= 2) {
                isValid = NO;
                temp = [resultStr substringFromIndex:matchCount - 1];
            }
        }
        if (!isValid) {
            textField.text = temp;
        }
        return isValid;
    }
    return YES;
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

/**
 判断小数点是否超过1个

 @param resultStr 字符串
 @return 如果小数点个数超过1个，则返回YES，否则返回NO
 */
- (BOOL)hasMoreThanOneDecimalPoint:(NSString *)resultStr {
    NSArray *componetsSeparateByDot = [resultStr componentsSeparatedByString:@"."];
    if ([componetsSeparateByDot count] > 2) {  /** 最多输入一个小数点 */
        return YES;
    }
    return NO;
}

/**
 判断一个数字的小数位是否超过2位

 @param resultStr 数字字符串
 @return BOOL值，YES：数字小数位超过2位，否则返回NO
 */
- (BOOL)hasMoreThanTwoDecimalDigits:(NSString *)resultStr {
    if ([resultStr containsString:@"."]) {
        NSArray *componetsSeparateByDot = [resultStr componentsSeparatedByString:@"."];
        NSString *decimals = componetsSeparateByDot[1];
        if ([decimals length] > 2) {  /** 小数点后超过两位 */
            return YES;
        }
    }
    return NO;
}

/**
 判断字符串中包含的字符都是合法字符，合法字符集是：0123456789.

 @param string 字符串
 @return 所有字符都是合法字符集中元素，则返回YES，否则返回NO
 */
- (BOOL)isAllNumberOrDot:(NSString *)string {
    NSCharacterSet *inputStrSet = [NSCharacterSet characterSetWithCharactersInString:string];
    if ([self.allowCharacterSet isSupersetOfSet:inputStrSet]) { /** 合法字符串 */
        return YES;
    }
    return NO;
}

- (BOOL)isFirstCharacterDecimalPoint:(NSString *)resultStr {
    return [resultStr hasPrefix:@"."];
}

#pragma mark -

- (void)errorWithErrorCode:(ACIInputValidateErrorCode)code Desc:(NSString *)desc error:(NSError **)error {
    if (error) {
        *error = [NSError errorWithDomain:kTextFieldInputValidationErrorDomain code:code userInfo:@{NSLocalizedDescriptionKey:desc}];
    }
}

#pragma mark - getter & setter

- (NSCharacterSet *)allowCharacterSet {
    if (!_allowCharacterSet) {
        NSMutableCharacterSet *temp = [NSMutableCharacterSet decimalDigitCharacterSet];
        [temp addCharactersInString:@"."];
        _allowCharacterSet = temp.copy;
    }
    return _allowCharacterSet;
}

@end
