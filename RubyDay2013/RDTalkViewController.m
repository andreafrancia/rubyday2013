//
//  RDTalkViewController.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDTalkViewController.h"
#import "RDDatasource.h"

@interface RDTalkViewController ()

@end

@implementation RDTalkViewController {
    NSDictionary *talkInfo;
    NSMutableArray *speakers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithTalkDictionary:(NSDictionary *)talkDictionary
{
    self = [self initWithNibName:@"RDTalkViewController" bundle:[NSBundle mainBundle]];

    if (self)
    {
        talkInfo = talkDictionary;
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"Talk details";

    NSArray *speakersHandles = talkInfo[@"speakers"];
    speakers = [NSMutableArray arrayWithCapacity:speakersHandles.count];

    for (NSString *speakerHandle in speakersHandles)
    {
        [speakers addObject:[[RDDatasource currentSource] speakerWithTwitterHandle:speakerHandle]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
