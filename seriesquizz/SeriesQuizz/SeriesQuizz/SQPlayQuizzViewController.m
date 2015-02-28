//
//  SQPlayQuizzViewController.m
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import "SQPlayQuizzViewController.h"
#import "SQClient.h"

@implementation SQPlayQuizzViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.opQueue = [[NSOperationQueue alloc] init];
    self.opQueue.maxConcurrentOperationCount = 1;
    [SQClient fetchSongsByQuizzType:self selector:@selector(setSongsToListen:) quizzType:self.quizzType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) setSongsToListen:(NSArray*) songs
{
    NSMutableArray *nameSong = [[NSMutableArray alloc] init];
    for (SQSong *s in songs)
    {
        NSString *name = s.nameSeries;
        if (![nameSong containsObject:name])
            [nameSong addObject:name];
    }
    self.namesSong = nameSong;
    NSMutableArray *songToLoad = [[NSMutableArray alloc] init];
    NSMutableArray *songsTmp = [NSMutableArray arrayWithArray:songs];
    for (unsigned int i = 0; i < 5; ++i)
    {
        unsigned int j = arc4random() % songs.count;
        [songToLoad addObject:[songsTmp objectAtIndex:j]];
        [songsTmp removeObjectAtIndex:j];
    }
    self.songs = songToLoad;
    //Load songs in AVPlayer and set the firstSong...
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"KEYPATH: %@", keyPath);
    if ([keyPath isEqualToString:@"songIds"])
    {
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonValidateOnClick:(id)sender
{
    
}
@end
