//
//  UITalkCell.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/2/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDTalkCell.h"
#import "RDDatasource.h"

@implementation RDTalkCell {
}

@synthesize to, from, title, speakers, accessory;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold
{
    self.to.font = regular;
    self.from.font = regular;
    self.title.font = bold;
    self.speakers.font = regular;
    
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tablerow"]];

    self.to.text = data[@"to"];
    self.from.text = data[@"from"];
    self.title.text = data[@"title"];

    if (data[@"speakers"] == nil)
    {
        self.speakers.hidden = YES;
        self.accessory.hidden = YES;
    }
    else
    {
        self.speakers.hidden = NO;
        self.accessory.hidden = NO;

        self.speakers.text = [[RDDatasource currentSource] speakersListFromHandles:data[@"speakers"]];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
