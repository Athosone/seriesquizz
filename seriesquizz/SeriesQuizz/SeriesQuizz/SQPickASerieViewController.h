//
//  SQPickASerieViewController.h
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface SQPickASerieViewController : UITableViewController

@property (strong, nonatomic) MBProgressHUD         *hud;
@property (strong, nonatomic) NSArray               *quizzType;
@property (strong, nonatomic) NSArray               *songIds;
@property (strong, nonatomic) NSString              *type;


@end
