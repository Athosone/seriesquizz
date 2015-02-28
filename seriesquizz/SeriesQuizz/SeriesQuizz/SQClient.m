//
//  SQClient.m
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import "SQClient.h"
#import "SQSong.h"

@implementation SQClient

+ (void)fetchQuizzType:(id)target selector:(SEL)selector
{
        PFQuery      *query = [[PFQuery alloc] initWithClassName:@"SeriesSong"];
        
        [query selectKeys:@[@"quizzType"]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
           
            NSMutableArray *quizzTypes = [[NSMutableArray alloc] init];
            for (PFObject *row in results)
            {
                NSDictionary *tmpDict = [row dictionaryWithValuesForKeys:@[@"quizzType"]];
                if (![quizzTypes containsObject:(NSString*)[tmpDict objectForKey:@"quizzType"]])
                    [quizzTypes addObject:(NSString*)[tmpDict objectForKey:@"quizzType"]];
            }
            [target performSelector:selector withObject:quizzTypes];
        }];
}

+ (void) fetchSongIdByQuizzType:(id)target selector:(SEL)selector quizzType:(NSString *)type
{
    
    PFQuery      *query = [[PFQuery alloc] initWithClassName:@"SeriesSong"];
    
    [query selectKeys:@[@"objectId"]];
    [query whereKey:@"quizzType" equalTo:type];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error)
     {
         
         NSMutableArray *quizzTypes = [[NSMutableArray alloc] init];
         for (PFObject *row in results)
         {
             NSDictionary *tmpDict = [row dictionaryWithValuesForKeys:@[@"objectId"]];
             if (![quizzTypes containsObject:(NSString*)[tmpDict objectForKey:@"objectId"]])
                 [quizzTypes addObject:(NSString*)[tmpDict objectForKey:@"objectId"]];
         }
         NSLog(@"OBJECTID: %@", quizzTypes);
         [target performSelector:selector withObject:quizzTypes];
     }];
}

+ (void) fetchSongsByQuizzType:(id)target selector:(SEL)selector quizzType:(NSString *)type
{
    PFQuery      *query = [[PFQuery alloc] initWithClassName:@"SeriesSong"];
    
    [query whereKey:@"quizzType" equalTo:type];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSMutableArray *songsList = [[NSMutableArray alloc] init];
        for (PFObject *row in objects)
        {
            SQSong *tmpSong = [[SQSong alloc] init];
            
            
            tmpSong.nameSeries = [row objectForKey:@"nameSeries"];// [row dictionaryWithValuesForKeys:@[@"SeriesSong"]];
            tmpSong.quizzType = [row objectForKey:@"quizzType"];
            PFFile *file = [row objectForKey:@"seriesSong"];
            
            tmpSong.songUrl = [NSURL URLWithString:file.url];
           // tmpSong.song = :tmpSong.songUrl];
            NSLog(@"TMPSONG: %@", row);
            if (![songsList containsObject:tmpSong])
                [songsList addObject:tmpSong];
        }
        NSLog(@"SONGSLIST: %@", songsList);
        [target performSelector:selector withObject:songsList];
    }];
}

@end
