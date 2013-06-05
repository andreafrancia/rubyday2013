
//
//  RDTalkViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDTalkViewController.h"
#import "RDDatasource.h"
#import "RDSpeakerViewController.h"
#import "RDSpeakerCell.h"
#import "RDTalkInfoCell.h"

@interface RDTalkViewController ()

@end

@implementation RDTalkViewController {
    NSDictionary *talkInfo;
    NSArray *speakers;
    UIFont *eurostile;
    UIFont *eurostileTitle;
    UIFont *eurostileBold;
    UIFont *eurostileBoldTitle;
}

static NSString *kSpeakerCellIdentifier = @"SpeakerCell";
static NSString *kSepIdentifier = @"CellSep";
static NSString *kTitleCellIdentifier = @"TitleCell";
static NSString *kSpeakersCellIdentifier = @"SpeakersCell";
static NSString *kAbstractCellIdentifier = @"AbstractCell";
static NSString *kTalkInfoCellIdentifier = @"TalkInfoCell";

-(id)initWithTalkDictionary:(NSDictionary *)talkDictionary
{
    self = [super init];

    if (self)
    {
        talkInfo = talkDictionary;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Talk";

    eurostile = [UIFont fontWithName:@"Eurostile" size:15.0];
    eurostileTitle = [UIFont fontWithName:@"Eurostile" size:16.0];
    eurostileBold = [UIFont fontWithName:@"EurostileBold" size:15.0];
    eurostileBoldTitle = [UIFont fontWithName:@"EurostileBold" size:18.0];

    speakers = talkInfo[@"speakers"];

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

    UINib *nib1 = [UINib nibWithNibName:@"RDSpeakerCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:kSpeakerCellIdentifier];

    UINib *nib2 = [UINib nibWithNibName:@"RDTalkInfoCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib2 forCellReuseIdentifier:kTalkInfoCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4 + speakers.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTitleCellIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTitleCellIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UILabel *title = [[UILabel alloc] init];
            title.lineBreakMode = NSLineBreakByWordWrapping;
            title.font = eurostileBoldTitle;
            title.numberOfLines = 2;
            title.textAlignment = NSTextAlignmentCenter;
            title.text = talkInfo[@"title"];

            CGSize size = [title.text sizeWithFont:title.font
                                 constrainedToSize:CGSizeMake(cell.frame.size.width - 40, MAXFLOAT)
                                     lineBreakMode:NSLineBreakByWordWrapping];
            title.frame = CGRectMake(cell.frame.origin.x + 20,
                                    cell.frame.origin.y + 10,
                                    cell.frame.size.width - 40,
                                    size.height);

            [cell.contentView addSubview:title];
        }

        return cell;
    }
    else if (indexPath.row == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSpeakersCellIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: kSpeakersCellIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UILabel *text = [[UILabel alloc] init];
            text.font = eurostile;
            text.textColor = [UIColor colorWithRed:173/255.0 green:173/255.0 blue:173/255.0 alpha:1.0];
            text.textAlignment = NSTextAlignmentCenter;
            text.frame = CGRectMake(cell.frame.origin.x + 20,
                                    cell.frame.origin.y,
                                    cell.frame.size.width - 40,
                                    30);

            NSString *speakersStr = [[RDDatasource currentSource] speakersListFromHandles:speakers];
            text.text = speakersStr;

            [cell.contentView addSubview:text];
        }

        return cell;
    }
    else if (indexPath.row == 2)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kAbstractCellIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kAbstractCellIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
        }

        UITextView *text = [[UITextView alloc] init];
        text.font = eurostile;
        CGSize size = [talkInfo[@"abstract"] sizeWithFont:eurostile constrainedToSize:CGSizeMake(cell.frame.size.width - 40, 999) lineBreakMode:NSLineBreakByWordWrapping];
        text.frame = CGRectMake(cell.frame.origin.x + 20,
                                cell.frame.origin.y,
                                cell.frame.size.width - 40,
                                size.height + 30);
        text.editable = NO;
        text.scrollEnabled = NO;
        text.text = talkInfo[@"abstract"];

        [cell.contentView addSubview:text];

        return cell;
    }
    else if (indexPath.row == 3)
    {
        RDTalkInfoCell *cell = (RDTalkInfoCell *)[tableView dequeueReusableCellWithIdentifier:kTalkInfoCellIdentifier];

        NSDictionary *data = @{@"time": [NSString stringWithFormat:@"%@ - %@", talkInfo[@"from"], talkInfo[@"to"]],
                               @"track": [[RDDatasource currentSource] trackTitleFromTalk:talkInfo]};

        [cell setData:data withFont:eurostileTitle andFontBold:eurostileBoldTitle];

        return cell;
    }
    else
    {
        unsigned int index = indexPath.row - 4;

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
            RDSpeakerCell *cell = (RDSpeakerCell *)[tableView dequeueReusableCellWithIdentifier:kSpeakerCellIdentifier];

            NSString *speakerHandle = speakers[index / 2];
            NSDictionary *speakerInfo = [[RDDatasource currentSource] speakerWithTwitterHandle:speakerHandle];
            [cell setData:speakerInfo withFont:eurostile andFontBold:eurostileBold];

            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        CGSize size = [talkInfo[@"title"] sizeWithFont:eurostileBoldTitle constrainedToSize:CGSizeMake(tableView.frame.size.width - 40, 999) lineBreakMode:NSLineBreakByWordWrapping];

        return size.height + 10;
    }
    else if (indexPath.row == 1)
        return 30;
    else if (indexPath.row == 2)
    {
        CGSize size = [talkInfo[@"abstract"] sizeWithFont:eurostile constrainedToSize:CGSizeMake(tableView.frame.size.width - 40, 999) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 30;
    }
    else if (indexPath.row == 3)
    {
        return 45;
    }
    else
    {
        unsigned int index = indexPath.row - 4;

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
    if (indexPath.row > 3)
    {
        unsigned int index = indexPath.row - 4;

        if (index % 2 == 1)
        {
            NSString *speakerHandle = speakers[index / 2];
            NSDictionary *speakerInfo = [[RDDatasource currentSource] speakerWithTwitterHandle:speakerHandle];

            RDSpeakerViewController *speakerViewController = [[RDSpeakerViewController alloc] initWithSpeakerDictionary:speakerInfo];
            [self.navigationController pushViewController:speakerViewController animated:YES];
        }
    }
}

@end
