//
//  RDDatasource.h
//  RubyDay2013
//
//  Created by Federico Ravasio on 6/1/13.
//  Copyright (c) 2013 Webrain. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RDDatasource : NSObject

+ (id)currentSource;

- (NSArray *)speakers;
- (NSArray *)tracks;
- (NSDictionary *)speakerWithTwitterHandle:(NSString *)twitterHandle;
- (NSString *)speakersListFromHandles:(NSArray *)handles;
- (NSArray *)talksForTwitterHandle:(NSString *)twitterHandle;
- (NSString *)trackTitleFromTalk:(NSDictionary *)talk;
- (NSArray *)sponsorURLs;

@end
