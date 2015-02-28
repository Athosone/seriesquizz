//
//  SQSong.h
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQSong : NSObject

@property (strong, nonatomic) NSString              *objectId;
@property (strong, nonatomic) NSString              *nameSeries;
@property (strong, nonatomic) NSDate                *createdAt;
@property (strong, nonatomic) NSDate                *updatedAt;
@property (strong, nonatomic) NSData                *song;
@property (strong, nonatomic) NSString              *quizzType;
@property (strong, nonatomic) NSURL                 *songUrl;

@end
