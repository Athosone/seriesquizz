//
//  SQLoginViewController.h
//  SeriesQuizz
//
//  Created by Werck Ayrton on 18/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface SQLoginViewController : UIViewController

//ActivityIndicator
@property (strong, nonatomic) MBProgressHUD        *hud;
//TextField
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField2;
//Button
@property (strong, nonatomic) IBOutlet UIButton *needAccountButton;
@property (strong, nonatomic) IBOutlet UIButton *connectButton;
@property (strong, nonatomic) IBOutlet UIButton *connectButton2;

//IBAction
- (IBAction)connectButtonOnClick:(id)sender;
- (IBAction)needAccountButtonOnClick:(id)sender;
- (IBAction)resignTextField:(id)sender;

//Label
@property (strong, nonatomic) IBOutlet UILabel *labelLogin;
@property (strong, nonatomic) IBOutlet UILabel *labelPassword;
@property (strong, nonatomic) IBOutlet UIButton *labelNeedAnAccount;
@property (strong, nonatomic) IBOutlet UIButton *labelConnect;

@end
