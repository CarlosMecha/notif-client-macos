//
//  Requester.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationFactory.h"
#import "NotificationDisplay.h"

extern const NSInteger DefaultBufferSize;
extern const NSTimeInterval DefaultInterval;

/*
 * Class for requesting new notifications to the server.
 */
@interface Requester : NSObject {
    BOOL _stopped;
    NSMutableArray * _buffer;
}

/* Buffer size, by default 1024 */
@property NSInteger bufferSize;
/* Request interval in seconds, by default 2. */
@property NSTimeInterval interval;
@property (readonly) NSURL * url;
@property (readonly) NotificationFactory * factory;
@property (readonly) NSObject<NotificationDisplay> * display;

- (id) initWithUrl: (NSURL *) url factory: (NotificationFactory *) factory;
- (id) initWithUrlAndDisplay: (NSURL *) url factory: (NotificationFactory *) factory display:(NSObject<NotificationDisplay> *)display;
- (void) stop;
- (void) run;

@end
