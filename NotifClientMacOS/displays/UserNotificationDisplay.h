//
//  UserNotificationDisplay.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/21/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NotificationDisplay.h"

@interface UserNotificationDisplay : NSObject <NotificationDisplay> {
    NSMutableArray * _buffer;
}

@property (readonly) int bufferSize;

+ (void) setUp;

- (id) initWithBuffer:(int) size;

@end


