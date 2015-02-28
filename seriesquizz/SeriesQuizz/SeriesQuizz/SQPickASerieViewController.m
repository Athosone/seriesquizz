//
//  SQPickASerieViewController.m
//  SeriesQuizz
//
//  Created by Werck Ayrton on 19/12/2014.
//  Copyright (c) 2014 Nyu Web Developpement. All rights reserved.
//

#import "SQPickASerieViewController.h"
#import <Parse/Parse.h>
#import "SQClient.h"
#import "SQPlayQuizzViewController.h"

@implementation SQPickASerieViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    self.quizzType = nil;
    self.songIds = nil;
    [SQClient fetchQuizzType:self selector:@selector(setQuizzTypeResponse:)];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"playQuizz"])
    {
         SQPlayQuizzViewController  *pq = (SQPlayQuizzViewController*)[[[segue destinationViewController] viewControllers ]objectAtIndex:0];
        [pq setValue:self.songIds forKey:@"songIds"];
        pq.quizzType = self.type;
    }
}

- (void) setQuizzTypeResponse:(NSArray*) quizzsTypes
{
        self.quizzType = quizzsTypes;
        [self.tableView reloadData];
}

- (void) setSongIdForQuizz:(NSArray*) songIds
{
    self.songIds = songIds;
    [self performSegueWithIdentifier:@"playQuizz" sender:self];
}

- (void) viewWillAppear:(BOOL)animated
{
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (!self.quizzType)
        return 1;
    return self.quizzType.count;//[self count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (self.quizzType)
        if(indexPath.row < self.quizzType.count)
            cell.textLabel.text = [self.quizzType objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.type = cell.textLabel.text;
    [SQClient fetchSongIdByQuizzType:self selector:@selector(setSongIdForQuizz:) quizzType:cell.textLabel.text];
 }


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

@end
