//
//  ACIInputValidateError.h
//  ACIInputValidator
//
//  Created by Carya on 2018/9/13.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kTextFieldInputValidationErrorDomain = @"com.inputvalidator.error.ValidationErrorDomain";

typedef NS_ENUM(NSUInteger, ACIInputValidateErrorCode) {
    ACIInputValidateErrorCharInvalid,  /**< 输入字符不合法 */
    ACIInputValidateErrorFirstCharDecimalPoint,  /**< 首位字符是小数点 */
    ACIInputValidateErrorMoreThanOneDecimalPoint,  /**< 字符串包含超过1个小数点 */
    ACIInputValidateErrorPrefixZeroDigitExceedingOne, /**< 首部0的个数超过了1个 */
    ACIInputValidateErrorMoreThanTwoDecimalDigits,  /**< 小数位的位数超过了2位 */
    ACIInputValidateErrorGreaterThanMaxValue,  /**< 超过允许输入的最大值 */
    ACIInputValidateErrorNotLiesWithinInterval,  /**< 数字不在设定区间内 */
};
