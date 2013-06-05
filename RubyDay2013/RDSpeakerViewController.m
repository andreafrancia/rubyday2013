
//
//  RDSpeakerViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDSpeakerViewController.h"
#import "RDDatasource.h"
#import "RDTalkViewController.h"
#import "RDTalkCell.h"
#import "RDSpeakerHeaderCell.h"

@interface RDSpeakerViewController ()

@end

@implementation RDSpeakerViewController {
    NSDictionary *speakerInfo;
    NSArray *talks;
    UIFont *eurostile;
    UIFont *eurostileBold;
    UIFont *eurostileBoldTitle;
}

static NSString *kTitleCellIdentifier = @"TitleCell";
static NSString *kBioCellIdentifier = @"BioCell";
static NSString *kSepIdentifier = @"CellSep";
static NSString *kTalkCellIdentifier = @"TalksCell";

-(id)initWithSpeakerDictionary:(NSDictionary *)speakerDictionary
{
    self = [super init];

    if (self)
    {
        speakerInfo = speakerDictionary;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Speaker";

    eurostile = [UIFont fontWithName:@"Eurostile" size:15.0];
    eurostileBold = [UIFont fontWithName:@"EurostileBold" size:15.0];
    eurostileBoldTitle = [UIFont fontWithName:@"EurostileBold" size:18.0];

    talks = [[RDDatasource currentSource] talksForTwitterHandle: speakerInfo[@"handle"]];

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

    UINib *nib1 = [UINib nibWithNibName:@"RDTalkCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:kTalkCellIdentifier];

    UINib *nib2 = [UINib nibWithNibName:@"RDSpeakerHeaderCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:kTitleCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2 + talks.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        RDSpeakerHeaderCell *cell = (RDSpeakerHeaderCell *)[tableView dequeueReusableCellWithIdentifier:kTitleCellIdentifier];

        [cell setData:speakerInfo withFont:eurostile andFontBold:eurostileBoldTitle];

        return cell;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kBioCellIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kBioCellIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
        }

        UITextView *text = [[UITextView alloc] init];
        text.font = eurostile;
        CGSize size = [speakerInfo[@"bio"] sizeWithFont:eurostile constrainedToSize:CGSizeMake(cell.frame.size.width - 40, 999) lineBreakMode:NSLineBreakByWordWrapping];
        text.frame = CGRectMake(cell.frame.origin.x + 20,
                                cell.frame.origin.y,
                                cell.frame.size.width - 40,
                                size.height + 40);
        text.editable = NO;
        text.scrollEnabled = NO;
        text.text = speakerInfo[@"bio"];

        [cell.contentView addSubview:text];

        return cell;
    }
    else
    {
        unsigned int index = indexPath.row - 2;

        if (index % 2 == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSepIdentifier];

            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSepIdentifier];
                cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerowsep"]];
            }

            return cell;
        }
        else
        {
            RDTalkCell *cell = (RDTalkCell *)[tableView dequeueReusableCellWithIdentifier:kTalkCellIdentifier];

            NSDictionary *talkInfo = talks[index / 2];
            [cell setData:talkInfo withFont:eurostile andFontBold:eurostileBold];

            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 170;
    }
    else if (indexPath.row == 1)
    {
        CGSize size = [speakerInfo[@"bio"] sizeWithFont:eurostile constrainedToSize:CGSizeMake(tableView.frame.size.width - 40, 999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 40;
    }
    else
    {
        unsigned int index = indexPath.row - 2;

        if (index % 2 == 0)
            return 1;
        else
            return 45;
    }
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
    if (indexPath.row > 1)
    {
        unsigned int index = indexPath.row - 2;

        if (index % 2 == 1)
        {
            NSDictionary *talkInfo = talks[index / 2];

            RDTalkViewController *talkViewController = [[RDTalkViewController alloc] initWithTalkDictionary:talkInfo];
            [self.navigationController pushViewController:talkViewController animated:YES];
        }
    }
}

@end
