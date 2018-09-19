//
//  ACITextFieldInputValidator.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/1.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ACITextFieldInputValidator <NSObject>

- (BOOL)validateInput:(UITextField *)textField
    charactersInRange:(NSRange)range
    replacementString:(NSString *)string
                error:(NSError **)error;

- (BOOL)validateEndEditingInput:(UITextField *)textField error:(NSError **)error;

@end
