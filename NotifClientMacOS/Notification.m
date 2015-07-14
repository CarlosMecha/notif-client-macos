//
//  Notification.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import "Notification.h"

@implementation Notification

- (id) initWithId:(NSString *)uuid {
    self = [super init];
    if(self) {
        _uuid = [uuid copy];
    }
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat: @"Notification: id=%@ topic=%@", self.uuid, self.topic];
}

@end
