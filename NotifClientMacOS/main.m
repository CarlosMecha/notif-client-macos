//
//  main.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requester.h"
#import "NotificationFactory.h"
#import "NotificationDisplay.h"
#import "TextDisplay.h"
#import "UserNotificationDisplay.h"

Requester * requester = nil;
BOOL stopped;
BOOL started;

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
        
        NSObject<NotificationDisplay> * display;
        
        if([arg1 isEqualToString:@"-g"]) {
            if(argc != 3) {
                help();
                return 1;
            }
            [UserNotificationDisplay setUp];
            display = [[UserNotificationDisplay alloc] init];
            urlIndex = 2;
        } else {
            if(argc != 2) {
                help();
                return 1;
            }
            urlIndex = 1;
            display = [[TextDisplay alloc] init];
        }
        
        signal(SIGINT, stop);
        
        NSString * url = [NSString stringWithFormat:@"%s", argv[urlIndex]];
        started = false;
        
        NSURL * requestUrl = [NSURL URLWithString:url];
        NotificationFactory * formatter = [[NotificationFactory alloc] init];
        requester = [[Requester alloc] initWithUrlAndDisplay:requestUrl factory:formatter display:display];
        
        // Create thread.
        [NSThread detachNewThreadSelector:@selector(run) toTarget:requester withObject:nil];
        
        started = true;
        stopped = false;
        
        // Wait until something happens.
        while(!stopped) {
            [NSThread sleepForTimeInterval:0.5f];
        }
        
    }
    return 0;
}
