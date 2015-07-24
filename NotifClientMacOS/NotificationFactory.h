//
//  Formatter.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

/*
 * Factory to create notifications from a NSDictionary.
 */
@interface NotificationFactory : NSObject

- (Notification *) create: (NSDictionary *) dict error: (NSError *) error;

@end
