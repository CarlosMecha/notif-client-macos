//
//  Formatter.h
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

@interface Formatter : NSObject

- (Notification *) format: (NSDictionary *) dict error: (NSError *) error;

@end
