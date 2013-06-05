//
//  RDInfoViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDInfoViewController.h"
#import "RDInfoCell.h"
#import "RDDatasource.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface RDInfoViewController ()

@end

@implementation RDInfoViewController {
    NSArray *sponsors;
}

static NSString *kLogoIdentifier = @"LogoCell";
static NSString *kSepIdentifier = @"CellSep";
static NSString *kWebrainIdentifier = @"WebrainCell";
static NSString *kSponsorIdentifier = @"SponsorCell";

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

    sponsors = [[RDDatasource currentSource] sponsorURLs];

    self.title = @"About";
    
    [self styleTable];
}

- (void)styleTable
{
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pw_pattern"]];
    self.tableView.tableHeaderView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableheader"]];
    self.tableView.tableFooterView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablefooter"]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + 1 + sponsors.count + 1 + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    RDInfoCell *cell = (RDInfoCell*)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (indexPath.row == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kLogoIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLogoIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
            imageView.frame = CGRectMake(cell.frame.origin.x + 57,
                                         cell.frame.origin.y + 20,
                                         imageView.image.size.width,
                                         imageView.image.size.height);

            [cell.contentView addSubview:imageView];
        }

        return cell;
    }
    else if (indexPath.row == 1 || indexPath.row == (sponsors.count + 2))
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSepIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSepIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerowsep"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

        return cell;
    }
    else if (indexPath.row == (sponsors.count + 2) + 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kWebrainIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kWebrainIdentifier];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"webrain_logo"]];

            imageView.frame = CGRectMake(cell.frame.origin.x + 108,
                                         cell.frame.origin.y + 15,
                                         imageView.image.size.width,
                                         imageView.image.size.height);

            [cell.contentView addSubview:imageView];
        }

        return cell;
    }
    else
    {
        UITableViewCell *cell = nil;//[tableView dequeueReusableCellWithIdentifier:kSponsorIdentifier];

        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSponsorIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];

            UIImageView *imageView = [[UIImageView alloc] init];

            NSURL *url = sponsors[indexPath.row - 2];
            imageView.contentMode = UIViewContentModeScaleAspectFit;

            imageView.frame = CGRectMake(cell.frame.origin.x + 60, cell.frame.origin.y + 10, 200, 40);

            [imageView setImageWithURL:url];
            cell.contentView.contentMode = UIViewContentModeCenter;
            [cell.contentView addSubview:imageView];
        }

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return [UIImage imageNamed:@"logo"].size.height + 40;
    else if (indexPath.row == 1)
        return 1;
    else if (indexPath.row == (sponsors.count + 2))
        return 1;
    else if (indexPath.row == (sponsors.count + 2) + 1)
        return [UIImage imageNamed:@"webrain_logo"].size.height + 30;
    else
    {
        return 60;
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
