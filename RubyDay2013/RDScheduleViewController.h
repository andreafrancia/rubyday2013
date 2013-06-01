//
//  RDScheduleControllerViewController.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDScheduleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UISegmentedControl *trackControl;
@property (retain, nonatomic) IBOutlet UITableView *table;

-(IBAction)trackChanged:(id)sender;

@end
