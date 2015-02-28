//
//  SQLoginViewController.m
//  SeriesQuizz
//
//  Created by Werck Ayrton on 18/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import "SQLoginViewController.h"
#import <Parse/Parse.h>

@implementation SQLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.loginTextField.text = @"toto";
    self.passwordTextField.text = @"titi";
    self.connectButton2.hidden = TRUE;
    
    //Init ActivityIndicator
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.hidden = TRUE;
    self.hud.labelText = NSLocalizedString(@"Connecting", nil);
    
    [self.loginTextField becomeFirstResponder];
    
    //initLabel
    [self.labelConnect sizeToFit];
    [self.labelLogin sizeToFit];
    [self.labelNeedAnAccount sizeToFit];
    [self.labelPassword sizeToFit];
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//hide keyboard
- (IBAction)resignTextField:(id)sender
{
    [sender resignFirstResponder];
}

//connection established with server, parse result to know the result
- (void) resultLogin:(PFUser *)user error:(NSError *)error
{
    if (error)
        [self connectionFailed:[error localizedDescription]];
    else
    {
        self.labelConnect.hidden = FALSE;
        self.hud.hidden = TRUE;
        [self performSegueWithIdentifier:@"loginSuccess" sender:self];
    }
}

- (void) resultSignin:(NSNumber *)result error:(NSError *)error
{
    self.labelConnect.hidden = FALSE;
    self.hud.hidden = TRUE;
    if (error)
        [self connectionFailed:[error localizedDescription]];
    else
    {
        if ([result boolValue])
            NSLog(@"user added");
    }
}

//fail to established connection with the server
- (void) connectionFailed:(NSString *)error
{
    self.labelConnect.hidden = FALSE;
    self.hud.hidden = TRUE;
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:NSLocalizedString(@"Oops !", nil)
                                          message:@""
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Ok", nil)
                               style:UIAlertActionStyleCancel
                               handler:^(UIAlertAction *action)
                               {
                                   self.passwordTextField.text = @"";
                               }];
    [alertController addAction:okAction];
    
    NSLog(@"Connection Fail, reason: %@", error);
    [alertController setMessage:NSLocalizedString(@"Invalid credentials", nil)];
    [self presentViewController:alertController animated:YES completion:nil];
}

//prepare view changing
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"loginSuccess"])
    {
        
    }
}
//Make something more generic that check if information entered by user are ok
//Onclick button method for login button
- (IBAction)connectButtonOnClick:(id)sender
{
    if ([self.passwordTextField.text isEqualToString:@""])
    {
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:NSLocalizedString(@"Oops !", nil)
                                              message:NSLocalizedString(@"You forget to type your password :", nil)
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
         {
             textField.placeholder = NSLocalizedString(@"password", nil);
             textField.secureTextEntry = YES;
         }];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           return;
                                       }];
        UIAlertAction *loginAction = [UIAlertAction
                                      actionWithTitle:NSLocalizedString(@"Login", nil)
                                      style:UIAlertActionStyleDefault
                                      handler:^(UIAlertAction *action)
                                      {
                                          UITextField *passwordAlertController = [alertController.textFields objectAtIndex:0];
                                          if ([passwordAlertController.text isEqualToString:@""])
                                              return;
                                          self.hud.hidden = FALSE;
                                          [PFUser logInWithUsernameInBackground:self.loginTextField.text password:passwordAlertController.text target:self selector:@selector(resultLogin:error:)];
                                      }];
        [alertController addAction:cancelAction];
        [alertController addAction:loginAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        self.labelConnect.hidden = TRUE;
        [PFUser logInWithUsernameInBackground:self.loginTextField.text password:self.passwordTextField.text target:self selector:@selector(resultLogin:error:)];
        self.hud.hidden = FALSE;
    }
}

//Onclick button method for need an account button
- (IBAction)needAccountButtonOnClick:(id)sender
{
    
    if ([[self.needAccountButton titleLabel].text isEqualToString:NSLocalizedString(@"Need an Account ?", nil)])
    {
        [self.needAccountButton setTitle:NSLocalizedString(@"Create and GO!", nil) forState:UIControlStateNormal];
        self.passwordTextField2.hidden = FALSE;
        self.connectButton2.hidden = FALSE;
        self.connectButton.hidden = TRUE;
    }
    else
    {
        UIAlertController   *alertController = [UIAlertController
                                                alertControllerWithTitle:NSLocalizedString(@"Oops !", nil)
                                                message:NSLocalizedString(@"You forget to type your email", nil)
                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Ok", nil)
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       self.loginTextField.text = @"";
                                       self.passwordTextField.text = @"";
                                       self.passwordTextField2.text = @"";
                                   }];
        [alertController addAction:okAction];
        //Checking if something is missing before sending it to the server
        if ([self.passwordTextField.text isEqualToString:self.passwordTextField2.text] && ![self.passwordTextField.text isEqualToString:@""])
        {
            if ([self.loginTextField.text isEqualToString:@""])
            {
                [alertController setMessage:NSLocalizedString(@"You forget to type your email", nil)];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                self.hud.hidden = FALSE;
                PFUser *user = [[PFUser alloc] init];
                user.username = self.loginTextField.text;
                user.password = self.passwordTextField.text;
                [user signUpInBackgroundWithTarget:self selector:@selector(resultSignin:error:)];
            }
        }
        else
        {
            [alertController setMessage:NSLocalizedString(@"Your password aren't the same", nil)];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
}

@end
