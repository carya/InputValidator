//
//  ViewController.m
//  ACIInputValidator
//
//  Created by Carya on 2018/9/11.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import "ViewController.h"
#import "ACIInputValidateTextField.h"
#import "ACIPriceInputValidator.h"
#import "ACINumericInputValidator.h"
#import "ACINumberOpenInterval.h"
#import "ACIMaxLengthLimitValidator.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet ACIInputValidateTextField *priceTextField;
@property (weak, nonatomic) IBOutlet ACIInputValidateTextField *naturalNumberTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.priceTextField.delegate = self;
    ACIPriceInputValidator *validator = [ACIPriceInputValidator new];
    NSDecimalNumber *maxValue = [NSDecimalNumber decimalNumberWithString:@"1000000000"];
    validator.interval = [[ACINumberOpenInterval alloc] initWithLowerBound:[NSDecimalNumber decimalNumberWithString:@"0"] upperBound:maxValue];
    self.priceTextField.inputValidator = validator;
    
    self.naturalNumberTextField.delegate = self;
    ACINumericInputValidator *numberValidator = [ACINumericInputValidator new];
    numberValidator.interval = [[ACINumberOpenInterval alloc] initWithLowerBound:[NSDecimalNumber decimalNumberWithString:@"0"] upperBound:[NSDecimalNumber decimalNumberWithString:@"100"]];
    self.naturalNumberTextField.inputValidator = numberValidator;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isKindOfClass:[ACIInputValidateTextField class]]) {
        return [(ACIInputValidateTextField *)textField validateCharactersInRange:range replacementString:string error:nil];
    }
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField isKindOfClass:[ACIInputValidateTextField class]]) {
        BOOL isValid = [(ACIInputValidateTextField *)textField validateEndEditingWithError:nil];
        NSLog(@"textField.text: %@ is valid: %@", textField.text, @(isValid));
    }
    
}

#pragma mark - event handler

- (IBAction)btnTouched:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}


@end
