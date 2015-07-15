//
//  Requester.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Formatter.h"

@interface Requester : NSObject {
    BOOL _stopped;
}

@property (readonly) NSTimeInterval secs;
@property (readonly) NSURL * url;
@property (readonly) Formatter * formatter;

- (id) initWithUrl: (NSURL *) url interval: (NSTimeInterval) secs formatter: (Formatter *) formatter;
- (void) stop;
- (void) run;

@end
