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

- (void)setData:(NSDictionary *)data;
{
    UIFont *eurostile = [UIFont fontWithName:@"Eurostile" size:15.0];
    UIFont *eurostileBold = [UIFont fontWithName:@"EurostileBold" size:15.0];

    self.to.font = eurostile;
    self.from.font = eurostile;
    self.title.font = eurostileBold;
    self.speakers.font = eurostile;
    
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

        NSMutableString *speakersStr = [[NSMutableString alloc] init];
        for (NSString *speaker in data[@"speakers"])
        {
            NSDictionary *speakerInfo = [[RDDatasource currentSource] speakerWithTwitterHandle:speaker];

            [speakersStr appendString:speakerInfo[@"name"]];
            [speakersStr appendString:@" - "];
        }
        self.speakers.text = [speakersStr substringToIndex:speakersStr.length - 3];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
