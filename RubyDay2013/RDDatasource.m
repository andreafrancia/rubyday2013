//
//  RDDatasource.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDDatasource.h"

@implementation RDDatasource {
    NSArray *tracks;
    NSArray *speakers;
}

static RDDatasource *dataSource = nil;

+ (id)currentSource
{
    @synchronized(self)
    {
        if (dataSource == nil)
        {
            dataSource = [[self alloc] init];
        }
    }

    return dataSource;
}

- (id)init
{
    self = [super init];

    if (self)
    {
        NSURL *url = [NSURL URLWithString:@"http://webrain.it/rubyday2013/content.json"];
        NSData* data = [NSData dataWithContentsOfURL:url];
        NSError *error;
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        tracks = content[@"tracks"];
        speakers = content[@"speakers"];
    }

    return self;
}

NSInteger sortSpeakers(id _speaker1, id _speaker2, void *context)
{
    NSDictionary *speaker1 = (NSDictionary *)_speaker1;
    NSDictionary *speaker2 = (NSDictionary *)_speaker2;

    NSString *name1 = speaker1[@"name"];
    NSString *name2 = speaker2[@"name"];

    return [name1 compare:name2];
}

- (NSArray *)speakers
{
    return [speakers sortedArrayUsingFunction:sortSpeakers context:nil];
}

- (NSArray *)tracks
{
    return tracks;
}

- (NSDictionary *)speakerWithTwitterHandle:(NSString *)twitterHandle
{
    for (NSDictionary *speaker in speakers)
        if ([speaker[@"handle"] isEqualToString:twitterHandle])
            return speaker;

    return @{};
}

@end
