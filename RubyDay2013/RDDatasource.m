//
//  RDDatasource.m
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import "RDDatasource.h"
#import "Reachability.h"

@implementation RDDatasource {
    NSArray *tracks;
    NSArray *speakers;
    NSArray *sponsorURLs;
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
        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

        NSData* data = nil;

        if (networkStatus == NotReachable) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"schedule" ofType:@"json"];
            data = [NSData dataWithContentsOfFile:path];
        }
        else
        {
            NSURL *url = [NSURL URLWithString:@"http://webrain.it/rubyday2013/content.json"];
            data = [NSData dataWithContentsOfURL:url];
        }
        
        NSError *error;
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

        tracks = content[@"tracks"];
        speakers = content[@"speakers"];
        sponsorURLs = content[@"sponsors"];
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

- (NSString *)speakersListFromHandles:(NSArray *)handles
{
    NSMutableString *speakersStr = [[NSMutableString alloc] init];

    for (NSString *speaker in handles)
    {
        NSDictionary *speakerInfo = [self speakerWithTwitterHandle:speaker];

        [speakersStr appendString:speakerInfo[@"name"]];
        [speakersStr appendString:@" - "];
    }

    return [speakersStr substringToIndex:speakersStr.length - 3];
}

- (NSArray *)talksForTwitterHandle:(NSString *)twitterHandle
{
    NSMutableArray *talks = [NSMutableArray array];

    for (NSDictionary *track in tracks)
    {
        for (NSDictionary *talk in track[@"schedule"])
        {
            if ([talk[@"speakers"] containsObject:twitterHandle])
            {
                [talks addObject:talk];
            }
        }
    }

    return talks;
}

- (NSString *)trackTitleFromTalk:(NSDictionary *)talkInfo
{
    for (NSDictionary *track in tracks)
    {
        for (NSDictionary *talk in track[@"schedule"])
        {
            if ([talk isEqualToDictionary:talkInfo])
                return track[@"name"];
        }
    }

    return @"Track #???";
}

- (NSArray *)sponsorURLs
{
    NSMutableArray *ary = [NSMutableArray arrayWithCapacity:sponsorURLs.count];

    for (NSString *url in sponsorURLs)
        [ary addObject:[NSURL URLWithString:url]];

    return ary;
}

@end
