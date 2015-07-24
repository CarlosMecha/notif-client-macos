//
//  Notification.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Notification class.
 */
@interface Notification : NSObject {
    NSString * dateRepresentation;
}

@property (copy, readonly) NSString *uuid;
@property (copy) NSString *topic;
@property (copy) NSDictionary *payload;
@property NSTimeInterval timestamp;

- (id)initWithId:(NSString *) uuid;

/*
 * Uses the payload to generate the representation of a notification.
 */
- (NSString *) description;

@end
