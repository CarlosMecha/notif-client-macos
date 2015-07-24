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
}

/*
 * This method should be called to configure the GUI.
 */
+ (void) setUp;

@end


