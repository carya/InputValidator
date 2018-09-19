//
//  ACIMaxLengthLimitValidator.h
//  TextFieldInputValidator
//
//  Created by Carya on 2018/9/11.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACITextFieldInputValidator.h"

@interface ACIMaxLengthLimitValidator : NSObject <ACITextFieldInputValidator>

@property (nonatomic, assign) NSInteger maxLengthLimit;

@end
