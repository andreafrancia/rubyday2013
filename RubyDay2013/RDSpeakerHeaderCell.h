//
//  RDSpeakerHeaderCell.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/5/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDSpeakerHeaderCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UIImageView *avatar;
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *handle;

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold;

@end
