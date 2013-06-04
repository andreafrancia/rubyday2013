//
//  RDSpeakerCell.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/4/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDSpeakerCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *speakers;
@property (retain, nonatomic) IBOutlet UIImageView *accessory;
@property (retain, nonatomic) IBOutlet UIImageView *avatar;

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold;

@end
