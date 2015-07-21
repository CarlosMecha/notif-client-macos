//
//  UserNotificationDisplay.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/21/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//
//  NSBundle fake implementation by Norio Nomura
//  https://github.com/norio-nomura/usernotification
//


#import "UserNotificationDisplay.h"
#import "Notification.h"
#import "NSMutableArray+QueueAdditions.h"

#import <objc/runtime.h>

NSString * fakeBundleIdentifier = nil;

@implementation NSBundle(Fake)

- (NSString *)__bundleIdentifier
{
    if (self == [NSBundle mainBundle]) {
        return fakeBundleIdentifier ? fakeBundleIdentifier : @"com.apple.finder";
    } else {
        return [self __bundleIdentifier];
    }
}

@end


@interface NotificationCenterDelegate : NSObject<NSUserNotificationCenterDelegate>
@end

@implementation NotificationCenterDelegate

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification {
    NSLog(@"Notification published");
}

@end

@implementation UserNotificationDisplay

static NSUserNotificationCenter * center;
static NotificationCenterDelegate * delegate;

+ (void) setUp {
    
    Class class = objc_getClass("NSBundle");
    if(class) {
        method_exchangeImplementations(class_getInstanceMethod(class, @selector(bundleIdentifier)), class_getInstanceMethod(class, @selector(__bundleIdentifier)));
    }
    
    fakeBundleIdentifier = [[NSUserDefaults standardUserDefaults] stringForKey:@"identifier"];
    
    center = [NSUserNotificationCenter defaultUserNotificationCenter];
    delegate = [[NotificationCenterDelegate alloc]init];

}

- (id) initWithBuffer:(int)size {
    self = [super init];
    if(self) {
        _bufferSize = size;
        _buffer = [[NSMutableArray alloc] initWithCapacity:_bufferSize];
    }
    return self;
}

- (void) display:(Notification *)notification {
 
    NSUserNotification * notif = [[NSUserNotification alloc] init];
    notif.title = [notification topic];
    notif.informativeText = [[notification payload] valueForKey:@"text"];
    notif.soundName = NSUserNotificationDefaultSoundName;
    
    [center deliverNotification:notif];

}

@end
