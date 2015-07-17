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
    if(!dateRepresentation) {
        NSDate * date = nil;
        if(_timestamp) {
            date = [[NSDate alloc] initWithTimeIntervalSince1970:(_timestamp / 1000.0)];
        } else {
            date = [NSDate date];
        }
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:SS"];
        dateRepresentation = [dateFormat stringFromDate:date];
    }
    
    if(_payload && [_payload valueForKey:@"text"]) {
        return [NSString stringWithFormat: @"%@ - %@: %@", dateRepresentation, _topic, [_payload valueForKey:@"text"]];
    }
    
    return [NSString stringWithFormat: @"%@ - %@", dateRepresentation, _topic];
    
}

@end
