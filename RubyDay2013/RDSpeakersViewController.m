//
//  RDSpeakersViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDSpeakersViewController.h"
#import "RDDatasource.h"
#import "RDSpeakerViewController.h"
#import "RDSpeakerCell.h"

@interface RDSpeakersViewController ()

@end

@implementation RDSpeakersViewController {
    NSArray *speakers;
    UIFont *eurostile;
    UIFont *eurostileBold;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Speakers";

    eurostile = [UIFont fontWithName:@"Eurostile" size:15.0];
    eurostileBold = [UIFont fontWithName:@"EurostileBold" size:15.0];

    speakers = [[RDDatasource currentSource] speakers];

    [self styleTable];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)styleTable
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pw_pattern"]];
    self.tableView.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheader"]];
    self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablefooter"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UINib *nib = [UINib nibWithNibName:@"RDSpeakerCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"Cell"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return speakers.count * 2 - 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell";
    static NSString *kSepIdentifier = @"CellSep";

    if (indexPath.row % 2 == 0)
    {
        RDSpeakerCell *cell = (RDSpeakerCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];

        NSDictionary *speaker = speakers[indexPath.row / 2];
        [cell setData:speaker withFont:eurostile andFontBold:eurostileBold];

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0)
        return 45;
    else
        return 1;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *speakerInfo = speakers[indexPath.row / 2];

    RDSpeakerViewController *speakerViewController = [[RDSpeakerViewController alloc] initWithSpeakerDictionary:speakerInfo];
    [self.navigationController pushViewController:speakerViewController animated:YES];
}

@end
