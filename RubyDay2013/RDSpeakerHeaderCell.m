//
//  RDSpeakerHeaderCell.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/5/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDSpeakerHeaderCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>

@implementation RDSpeakerHeaderCell

@synthesize name, handle, avatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];
    avatar.layer.cornerRadius  = 47;
    avatar.layer.masksToBounds = YES;
}

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold
{
    name.font = bold;
    handle.font = regular;

    name.text = data[@"name"];
    handle.text = [NSString stringWithFormat:@"@%@", data[@"handle"]];
    
    NSString *avatarUrl = [NSString stringWithFormat:@"http://api.twitter.com/1/users/profile_image?screen_name=%@&size=original", data[@"handle"]];
    [avatar setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"rubylang"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
