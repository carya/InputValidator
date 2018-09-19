//
//  ACIMaxLengthLimitValidator.m
//  TextFieldInputValidator
//
//  Created by Carya on 2018/9/11.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import "ACIMaxLengthLimitValidator.h"

@implementation ACIMaxLengthLimitValidator

- (BOOL)validateInput:(UITextField *)textField
    charactersInRange:(NSRange)range
    replacementString:(NSString *)string
                error:(NSError **)error {
    
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return YES;
    }
    
    NSInteger maxInputNum = self.maxLengthLimit;
    NSString *comcatstr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger caninputlen = maxInputNum - comcatstr.length;
    if (caninputlen < 0) {
        NSInteger len = string.length + caninputlen;
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    return YES;
}

- (BOOL)validateEndEditingInput:(UITextField *)textField error:(NSError **)error {
    return YES;
}

@end
