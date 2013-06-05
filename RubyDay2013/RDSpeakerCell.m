//
//  RDSpeakerCell.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/4/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDSpeakerCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation RDSpeakerCell

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
    self.avatar.layer.cornerRadius = 17.0;
    self.avatar.layer.masksToBounds = YES;
}

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold
{
    self.title.font = bold;
    self.speakers.font = regular;
    
    self.title.text = data[@"name"];
    self.speakers.text = [NSString stringWithFormat:@"@%@", data[@"handle"]];
    
    [self.avatar setImage:[UIImage imageNamed:[NSString stringWithFormat:@"twitter_%@", data[@"handle"]]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
