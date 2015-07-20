//
//  main.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requester.h"
#import "Formatter.h"

#import <objc/runtime.h>

Requester * requester = nil;
BOOL stopped;
BOOL started;

NSString *fakeBundleIdentifier = nil;

@implementation NSBundle(swizle)

// Overriding bundleIdentifier works, but overriding NSUserNotificationAlertStyle does not work.

- (NSString *)__bundleIdentifier
{
    if (self == [NSBundle mainBundle]) {
        return fakeBundleIdentifier ? fakeBundleIdentifier : @"com.apple.finder";
    } else {
        return [self __bundleIdentifier];
    }
}

@end

BOOL installNSBundleHook()
{
    Class class = objc_getClass("NSBundle");
    if (class) {
        method_exchangeImplementations(class_getInstanceMethod(class, @selector(bundleIdentifier)),
                                       class_getInstanceMethod(class, @selector(__bundleIdentifier)));
        return YES;
    }
    return NO;
}

@interface NotificationCenterDelegate : NSObject<NSUserNotificationCenterDelegate>

@property (nonatomic, assign) BOOL keepRunning;

@end

@implementation NotificationCenterDelegate

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    self.keepRunning = NO;
}

@end


void stop() {
    NSLog(@"Received shutdown order.");
    
    if(requester) {
        [requester stop];
    }
    
    // Waiting for the thread a little bit longer.
    if(started) {
        [NSThread sleepForTimeInterval:2.0f];
    }
    
    stopped = true;
}

void toStdout(NSString * url) {
    
    NSURL * requestUrl = [NSURL URLWithString:url];
    Formatter * formatter = [[Formatter alloc] init];
    requester = [[Requester alloc] initWithUrl:requestUrl interval:2.0f formatter:formatter];
    
    // Create thread.
    [NSThread detachNewThreadSelector:@selector(run) toTarget:requester withObject:nil];
    
    started = true;
    stopped = false;
    
    // Wait until something happens.
    while(!stopped) {
        [NSThread sleepForTimeInterval:0.5f];
    }
    
}

void toGUI(NSString * url) {

    installNSBundleHook();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    fakeBundleIdentifier = [defaults stringForKey:@"identifier"];
    
    NSUserNotificationCenter * nc = [NSUserNotificationCenter defaultUserNotificationCenter];
    NotificationCenterDelegate * ncDelegate = [[NotificationCenterDelegate alloc]init];
    ncDelegate.keepRunning = YES;
    nc.delegate = ncDelegate;
    
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Hello, Worlddddddddddd!";
    notification.informativeText = [NSString stringWithFormat:@"FUCK ANOS"];
    notification.soundName = NSUserNotificationDefaultSoundName;
 
    [nc deliverNotification:notification];
    
    while (ncDelegate.keepRunning) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
    }
    
    NSLog(@"Terminated");
    
}

void help() {
    NSLog(@"Usage: notifications [-g] <url>");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc < 2) {
            help();
            return 1;
        }
        
        NSString * arg1 = [NSString stringWithFormat:@"%s", argv[1]];
        
        int urlIndex;
        BOOL graphics = false;
        
        if([arg1 isEqualToString:@"-g"]) {
            if(argc != 3) {
                help();
                return 1;
            }
            graphics = true;
            urlIndex = 2;
        } else {
            if(argc != 2) {
                help();
                return 1;
            }
            urlIndex = 1;
        }
        
        signal(SIGINT, stop);
        
        NSString * url = [NSString stringWithFormat:@"%s", argv[urlIndex]];
        started = false;
        
        if(graphics) {
            toGUI(url);
        } else {
            toStdout(url);
        }
        
    }
    return 0;
}
