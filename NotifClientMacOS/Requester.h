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

@interface Requester : NSObject {
    BOOL _stopped;
}

@property (readonly) NSTimeInterval secs;
@property (readonly) NSURL * url;
@property (readonly) NotificationFactory * factory;
@property (readonly) NSObject<NotificationDisplay> * display;

- (id) initWithUrl: (NSURL *) url interval: (NSTimeInterval) secs factory: (NotificationFactory *) factory;
- (id) initWithUrlAndDisplay: (NSURL *) url interval: (NSTimeInterval) secs factory: (NotificationFactory *) factory display:(NSObject<NotificationDisplay> *)display;
- (void) stop;
- (void) run;

@end
