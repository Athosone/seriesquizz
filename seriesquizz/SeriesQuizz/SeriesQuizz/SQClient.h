//
//  SQClient.h
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import <AFNetworking/AFNetworking.h>

@interface SQClient : NSObject



+ (void)        fetchQuizzType:(id) target selector:(SEL)selector;
+ (void)        fetchSongIdByQuizzType:(id) target selector:(SEL)selector quizzType:(NSString*)type;
+ (void)        fetchSongsNamesByQuizzType:(id) target selector:(SEL)selector quizzType:(NSString*)type;
+ (void)        fetchSongsByQuizzType:(id) target selector:(SEL)selector quizzType:(NSString*)type;
@end
