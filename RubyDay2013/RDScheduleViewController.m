//
//  RDScheduleControllerViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDScheduleViewController.h"
#import "RDDatasource.h"

@interface RDScheduleViewController ()

@end

@implementation RDScheduleViewController {
    RDDatasource *dataSource;
    int currentTrack;
    NSArray *tracks;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Schedule";

    dataSource = [RDDatasource currentSource];
    tracks = dataSource.tracks;

    [self.trackControl removeAllSegments];
    int i = 0;
    for (NSDictionary *track in tracks) {
        [self.trackControl insertSegmentWithTitle:track[@"name"] atIndex:i animated:NO];
        i++;
    }

    currentTrack = 0;
    [self.trackControl setSelectedSegmentIndex:currentTrack];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)trackChanged:(id)sender
{
    UISegmentedControl *control = (UISegmentedControl *)sender;

    currentTrack = control.selectedSegmentIndex;

    [self.table reloadData];
}

#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark UITableViewDatasource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];

    NSArray *schedule = tracks[currentTrack][@"schedule"];
    NSDictionary *item = schedule[indexPath.row];

    cell.textLabel.text = item[@"title"];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *schedule = tracks[currentTrack][@"schedule"];
    return schedule.count;
}


@end
