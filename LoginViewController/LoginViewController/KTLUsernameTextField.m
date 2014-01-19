//
//  KTLUsernameTextField.m
//  LoginViewController
//
//  Created by Steven Baranski on 1/19/14.
//  Copyright (c) 2014 komorka technology, llc. All rights reserved.
//

#import "KTLUsernameTextField.h"

@implementation KTLUsernameTextField

#pragma mark - UITextField methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Private behavior

- (void)commonInit
{
    self.keyboardType = UIKeyboardTypeEmailAddress;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.returnKeyType = UIReturnKeyNext;
    self.placeholder = @"email@example.com";
}

@end
