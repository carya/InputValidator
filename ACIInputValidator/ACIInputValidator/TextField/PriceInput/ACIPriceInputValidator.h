//
//  ACIPriceInputValidator.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/1.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACITextFieldInputValidator.h"
#import "ACINumberInterval.h"

@interface ACIPriceInputValidator : NSObject <ACITextFieldInputValidator>

@property (nonatomic, strong) ACINumberInterval *interval;

@end
