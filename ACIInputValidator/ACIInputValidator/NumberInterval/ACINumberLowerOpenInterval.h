//
//  ACINumberLowerOpenInterval.h
//  ACITextFieldValidator
//
//  Created by Carya on 2018/9/11.
//  Copyright © 2018 CaryaLiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACINumberInterval.h"

/** (1, 10] */
@interface ACINumberLowerOpenInterval : ACINumberInterval

- (BOOL)contains:(NSNumber *)number;

@end
