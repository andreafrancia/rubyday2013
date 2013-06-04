//
//  UITalkCell.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/2/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDTalkCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *from;
@property (retain, nonatomic) IBOutlet UILabel *to;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *speakers;
@property (retain, nonatomic) IBOutlet UIImageView *accessory;

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold;

@end
