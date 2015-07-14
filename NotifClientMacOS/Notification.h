//
//  Notification.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notification : NSObject

@property (copy, readonly) NSString *uuid;
@property (copy) NSString *topic;
@property (copy) NSDictionary *payload;
@property (copy) NSString *timestamp;

- (id)initWithId:(NSString *) uuid;
- (NSString *) description;

@end
