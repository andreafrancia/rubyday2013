//
//  RDTalkInfoCell.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/5/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDTalkInfoCell.h"

@implementation RDTalkInfoCell

@synthesize time, time2, track;

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
}

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold
{
    time.font = bold;
    time2.font = regular;
    track.font = bold;

    time2.text = data[@"time"];
    track.text = data[@"track"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
