//
//  KTLLoginViewController.m
//  LoginViewController
//
//  Created by Steven Baranski on 1/2/13.
//  Copyright (c) 2013 komorka technology, llc. All rights reserved.
//

#import "KTLLoginViewController.h"

#import "KTLPasswordTextField.h"
#import "KTLUsernameTextField.h"

@interface KTLLoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIBarButtonItem *loginBarButtonItem;

@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

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

static CGFloat      KTLLoginTextFieldWidth = 190.0f;
static CGFloat      KTLLoginTextFieldHeight = 44.0f;

static NSString *   KTLCellReuseIdentifier = @"KTLCredentialCell";

#pragma mark - UIViewController lifecycle methods

- (void)didReceiveMemoryWarning
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [super didReceiveMemoryWarning];
}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        self.title = @"Contrived Service";
    }
    return self;
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

#pragma mark - UITableViewCell methods

- (void)configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
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
                    cell.textLabel.text = @"User Name";
                    cell.accessoryView = self.usernameTextField;
                    return;
                }
                case KTLLoginSectionRowPassword :
                {
                    cell.textLabel.text = @"Password";
                    cell.accessoryView = self.passwordTextField;
                    return;
                }
            }
        }
    }
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (KTLLoginSection == section)
    {
        return KTLLoginSectionRowCount;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTLCellReuseIdentifier
                                                            forIndexPath:indexPath];
    [self configureCell:cell forRowAtIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return KTLLoginTableSectionCount;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate methods

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

#pragma mark - IBActions methods

/// Acknowledges a successful simulated login attempt
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
    self.loginBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Login"
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
    CGRect credentialFieldRect = CGRectMake(0.0f, 0.0f, KTLLoginTextFieldWidth, KTLLoginTextFieldHeight);
    
    KTLUsernameTextField *userField = [[KTLUsernameTextField alloc] initWithFrame:credentialFieldRect];
    userField.delegate = self;
    self.usernameTextField = userField;
    
    KTLPasswordTextField *pwdField = [[KTLPasswordTextField alloc] initWithFrame:credentialFieldRect];
    pwdField.delegate = self;
    self.passwordTextField = pwdField;
}

- (void)updateView
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.usernameTextField becomeFirstResponder];
    }];
    [self updateLoginButton];
}

/// Enforces a contrived username & password policy
- (void)updateLoginButton
{
    BOOL usernameIsCompliant = ([self.usernameTextField.text length] > 0);
    BOOL passwordIsCompliant = ([self.passwordTextField.text length] > 0);
    
    self.loginBarButtonItem.enabled = (usernameIsCompliant && passwordIsCompliant);
}

@end
