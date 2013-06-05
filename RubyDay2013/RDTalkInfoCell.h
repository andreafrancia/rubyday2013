//
//  RDTalkInfoCell.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/5/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDTalkInfoCell : UITableViewCell

@property (retain, nonatomic) IBOutlet UILabel *time;
@property (retain, nonatomic) IBOutlet UILabel *time2;
@property (retain, nonatomic) IBOutlet UILabel *track;

- (void)setData:(NSDictionary *)data withFont:(UIFont *)regular andFontBold:(UIFont *)bold;

@end
