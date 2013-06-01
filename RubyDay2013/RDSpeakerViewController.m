//
//  RDSpeakerController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDSpeakerViewController.h"

@interface RDSpeakerViewController ()

@end

@implementation RDSpeakerViewController {
    NSDictionary *speakerInfo;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithSpeakerDictionary:(NSDictionary *)speakerDictionary
{
    self = [self initWithNibName:@"RDSpeakerViewController" bundle:[NSBundle mainBundle]];

    if (self)
    {
        speakerInfo = speakerDictionary;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = speakerInfo[@"name"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
