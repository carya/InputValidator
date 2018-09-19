//
//  ACIInputValidateTextField.h
//  TextFieldInputValidator
//
//  Created by CaryaLiu on 2018/9/2.
//  Copyright © 2018年 CaryaLiu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACITextFieldInputValidator.h"

@interface ACIInputValidateTextField : UITextField

@property (nonatomic, strong) id<ACITextFieldInputValidator> inputValidator;

- (BOOL)validateCharactersInRange:(NSRange)range
                replacementString:(NSString *)string
                            error:(NSError **)error;

- (BOOL)validateEndEditingWithError:(NSError **)error;

@end
