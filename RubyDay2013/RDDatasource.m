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

- (NSArray *)speakers
{
    return speakers;
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
