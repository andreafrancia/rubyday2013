//
//  RDScheduleControllerViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDScheduleViewController.h"
#import "RDDatasource.h"
#import "RDTalkViewController.h"
#import "SVSegmentedControl.h"
#import "RDTalkCell.h"

@interface RDScheduleViewController ()

@end

@implementation RDScheduleViewController {
    RDDatasource *dataSource;
    int currentTrack;
    NSArray *tracks;
    SVSegmentedControl *tracksControl;
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

    self.title = @"Agenda";

    dataSource = [RDDatasource currentSource];
    tracks = dataSource.tracks;

    [self buildTracksControl];
    [self styleTable];

    currentTrack = 0;
}

- (void)tracksControlChanged:(SVSegmentedControl*)segmentedControl {
    currentTrack = (int)segmentedControl.selectedSegmentIndex;

    [self.table reloadData];
}

- (void)buildTracksControl
{
    NSMutableArray *tracksNames = [NSMutableArray arrayWithCapacity:tracks.count];
    for (NSDictionary *track in tracks)
        [tracksNames addObject:track[@"name"]];

    UIColor *rubyRedColor = [UIColor colorWithRed:171/255.0 green:60/255.0 blue:30/255.0 alpha:1.0];

    tracksControl = [[SVSegmentedControl alloc] initWithSectionTitles:tracksNames];
    [tracksControl addTarget:self action:@selector(tracksControlChanged:) forControlEvents:UIControlEventValueChanged];
    tracksControl.frame = CGRectMake(0, 0, 320, 36);
    
    tracksControl.cornerRadius = 3.0;
    tracksControl.font = [UIFont fontWithName:@"EurostileBold" size:14];
	tracksControl.textColor = rubyRedColor;
    tracksControl.textShadowOffset = CGSizeMake(0, 0);
    tracksControl.textShadowColor = [UIColor colorWithWhite:1.0 alpha:0.0];
    tracksControl.innerShadowColor = [UIColor colorWithRed:160/255.0 green:160/255.0 blue:160/255.0 alpha:1.0];
    tracksControl.backgroundImage = [UIImage imageNamed:@"tracks_control_bg"];
	tracksControl.crossFadeLabelsOnDrag = YES;
    
	tracksControl.thumb.tintColor = rubyRedColor;
    tracksControl.thumb.textShadowColor = [UIColor colorWithWhite:0.5 alpha:1.0];

    [self.view addSubview:tracksControl];
}

- (void)styleTable
{
    self.table.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pw_pattern"]];
    self.table.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheader"]];
    self.table.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablefooter"]];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;

    UINib *nib = [UINib nibWithNibName:@"RDTalkCell" bundle:[NSBundle mainBundle]];
    [self.table registerNib:nib forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *schedule = tracks[currentTrack][@"schedule"];
    NSDictionary *talkInfo = schedule[indexPath.row / 2];

    if (talkInfo[@"speakers"] == nil)
        return;
    
    RDTalkViewController *talkViewController = [[RDTalkViewController alloc] initWithTalkDictionary:talkInfo];

    [self.navigationController pushViewController:talkViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)
        return 45;
    else
        return 1;
}

#pragma mark UITableViewDatasource -

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell";
    static NSString *kSepIdentifier = @"CellSep";

    if (indexPath.row % 2 == 0)
    {
        RDTalkCell *cell = (RDTalkCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

        NSArray *schedule = tracks[currentTrack][@"schedule"];
        NSDictionary *item = schedule[indexPath.row / 2];

        [cell setData:item];

        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSepIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSepIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerowsep"]];
        }

        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *schedule = tracks[currentTrack][@"schedule"];
    return schedule.count * 2 - 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor clearColor]];
}


@end
