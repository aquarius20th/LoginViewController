//
//  KTLLoginViewController.m
//  LoginViewController
//
//  Created by Steven Baranski on 1/2/13.
//  Copyright (c) 2013 komorka technology, llc. All rights reserved.
//

#import "KTLLoginViewController.h"

@interface KTLLoginViewController ()

<UITextFieldDelegate>

@property (nonatomic, strong) UIBarButtonItem *loginBarButtonItem;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

- (IBAction)loginTapped:(id)sender;

- (void)setupView;
- (void)updateView;
- (void)updateLoginButton;

@end

enum KTLLoginTableSections {
    KTLLoginSection = 0,
    KTLLoginTableSectionCount,
};

enum KTLLoginRows {
    KTLLoginSectionRowUsername = 0,
    KTLLoginSectionRowPassword,
    KTLLoginSectionRowCount,
};

@implementation KTLLoginViewController

// NB: these magic numbers should be addressed
static CGFloat KTLLoginTextFieldWidth = 180.0f;
static CGFloat KTLLoginTextFieldHeight = 44.0f;

static NSString *KTLCellReuseIdentifier = @"Cell";

#pragma mark - Initialization

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.title = @"Contrived Service";      // TODO: localize me
    }
    return self;
}

#pragma mark - UIViewController lifecycle

- (void)didReceiveMemoryWarning
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateView];
}

#pragma mark - UITableViewCell

- (void)updateCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section)
    {
        case KTLLoginSection :
        {
            switch (indexPath.row)
            {
                case KTLLoginSectionRowUsername :
                {
                    cell.textLabel.text = @"Username";              // TODO: localize me
                    cell.accessoryView = self.usernameTextField;
                    return;
                }
                case KTLLoginSectionRowPassword :
                {
                    cell.textLabel.text = @"Password";              // TODO: localize me
                    cell.accessoryView = self.passwordTextField;
                    return;
                }
                default :
                    NSLog(@"%s - unintelligible row %i", __PRETTY_FUNCTION__, indexPath.row);
                    break;
            }
        }
        default :
            NSLog(@"%s - unintelligible section %i", __PRETTY_FUNCTION__, indexPath.section);
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return KTLLoginTableSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case KTLLoginSection:
            return KTLLoginSectionRowCount;
        default :
            NSLog(@"%s - unintelligible section %i", __PRETTY_FUNCTION__, section);
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTLCellReuseIdentifier
                                                            forIndexPath:indexPath];
    [self updateCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self updateLoginButton];
    }];
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if (textField == self.passwordTextField)
    {
        [self updateLoginButton];
        if (YES == self.loginBarButtonItem.enabled)
        {
            [self loginTapped:textField];
        }
    }
	return NO;
}

#pragma mark - IBActions

- (IBAction)loginTapped:(id)sender
{
    NSString *message = [NSString stringWithFormat:@"Username: %@\nPassword: %@",
                         self.usernameTextField.text,
                         self.passwordTextField.text];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Tapped"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Private behavior

- (void)setupView
{
    // navigation item
    self.loginBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login"   // TODO: localize me
                                                               style:UIBarButtonItemStyleDone
                                                              target:self
                                                              action:@selector(loginTapped:)];
    self.navigationItem.rightBarButtonItem = self.loginBarButtonItem;
    
    // table
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2
                                                   reuseIdentifier:KTLCellReuseIdentifier];
    [self.tableView registerClass:[cell class]
           forCellReuseIdentifier:KTLCellReuseIdentifier];

    
    // text fields
    UITextField *userField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KTLLoginTextFieldWidth, KTLLoginTextFieldHeight)];
    userField.keyboardType = UIKeyboardTypeEmailAddress;
    userField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    userField.autocorrectionType = UITextAutocorrectionTypeNo;
    userField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    userField.delegate = self;
    userField.returnKeyType = UIReturnKeyNext;
    userField.placeholder = @"Enter username";      // TODO: localize me
    self.usernameTextField = userField;
    
    UITextField *pwdField = [[UITextField alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KTLLoginTextFieldWidth, KTLLoginTextFieldHeight)];
    pwdField.secureTextEntry = YES;
    pwdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pwdField.delegate = self;
    pwdField.returnKeyType = UIReturnKeyGo;
    pwdField.placeholder = @"Required";             // TODO: localize me
    self.passwordTextField = pwdField;
}

- (void)updateView
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.usernameTextField becomeFirstResponder];
    }];
    [self updateLoginButton];
}

- (void)updateLoginButton
{
    // NB: contrived username & password policy
    BOOL usernameIsCompliant = ([self.usernameTextField.text length] > 0);
    BOOL passwordIsCompliant = ([self.passwordTextField.text length] > 0);
    
    self.loginBarButtonItem.enabled = (usernameIsCompliant && passwordIsCompliant);
}

@end
