//
//  NotificationDisplay.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/21/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#ifndef NotifClientMacOS_NotificationDisplay_h
#define NotifClientMacOS_NotificationDisplay_h

#include "Notification.h"

@protocol NotificationDisplay<NSObject>

/*
 * Displays a notification.
 */
- (void) display:(Notification *)notification;

@end

#endif
