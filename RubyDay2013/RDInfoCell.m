//
//  RDInfoCell.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/5/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDInfoCell.h"
#import "RDDatasource.h"

@implementation RDInfoCell

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
