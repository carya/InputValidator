//
//  ACINumericInputValidator.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/1.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACITextFieldInputValidator.h"
#import "ACINumberInterval.h"

/** 验证输入的是自然数 */
@interface ACINumericInputValidator : NSObject <ACITextFieldInputValidator>

// 最小值如果大于0，则首位数字不能是0
@property (nonatomic, strong) ACINumberInterval *interval;

@end
