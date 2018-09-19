//
//  ACIInputValidateTextField.m
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/2.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import "ACIInputValidateTextField.h"

@implementation ACIInputValidateTextField

- (BOOL)validateCharactersInRange:(NSRange)range
                replacementString:(NSString *)string
                            error:(NSError **)error {
    
    BOOL shouldChange = [self.inputValidator validateInput:self charactersInRange:range replacementString:string error:error];
    return shouldChange;
}

- (BOOL)validateEndEditingWithError:(NSError **)error {
    BOOL isValid = [self.inputValidator validateEndEditingInput:self error:error];
    return isValid;
}

@end
