//
//  SQPlayQuizzViewController.h
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "APRoundedButton.h"
#import "SQSong.h"

@interface SQPlayQuizzViewController : UIViewController


@property (strong, nonatomic) NSArray                   *songIds;
@property (strong, nonatomic) NSArray                   *namesSong;
@property (strong, nonatomic) NSArray                   *songs;
@property (strong, nonatomic) NSString                  *quizzType;
@property (strong, nonatomic) AVPlayer                  *player;
@property (strong, nonatomic) NSOperationQueue          *opQueue;
@property (strong, nonatomic) NSString                  *response;

@property (strong, nonatomic) IBOutlet UILabel *labelSong;
@property (strong, nonatomic) IBOutlet APRoundedButton *buttonChoice1;
@property (strong, nonatomic) IBOutlet APRoundedButton *buttonChoice2;
@property (strong, nonatomic) IBOutlet APRoundedButton *buttonChoice3;
@property (strong, nonatomic) IBOutlet APRoundedButton *buttonChoice4;
@property (strong, nonatomic) IBOutlet APRoundedButton *buttonValidate;
- (IBAction)buttonValidateOnClick:(id)sender;

@end
