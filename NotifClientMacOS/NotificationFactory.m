//
//  Formatter.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import "NotificationFactory.h"

@implementation NotificationFactory

- (Notification *) create:(NSDictionary *)dict error:(NSError *)error {
    NSString * uuid = [dict valueForKey:@"uuid"];
    NSString * topic = [dict valueForKey:@"topic"];
    NSNumber * timestamp = [dict valueForKey:@"timestamp"];
    NSDictionary * payload = [dict valueForKey:@"payload"];
    
    if(!uuid || !topic || !timestamp || !payload) {
        error = [[NSError alloc] initWithDomain:@"notif-client.parse" code:((NSInteger) 1) userInfo:[dict copy]];
    }
    
    Notification * notification = [[Notification alloc] initWithId:uuid];
    notification.timestamp = [timestamp doubleValue];
    notification.topic = topic;
    notification.payload = payload;
    
    return notification;
}


@end
