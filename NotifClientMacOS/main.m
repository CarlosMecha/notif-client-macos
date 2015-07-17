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
        [NSThread sleepForTimeInterval:1000.0f];
    }
    
    stopped = true;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc != 2) {
            NSLog(@"Usage: notifications <url>");
            return 1;
        }
        
        signal(SIGINT, stop);

        started = false;
        
        NSString * url = [NSString stringWithFormat:@"%s", argv[1]];
        NSURL * requestUrl = [NSURL URLWithString:url];
        Formatter * formatter = [[Formatter alloc] init];
        requester = [[Requester alloc] initWithUrl:requestUrl interval:2.0f formatter:formatter];
        
        // Create thread.
        [NSThread detachNewThreadSelector:@selector(run) toTarget:requester withObject:nil];
        
        started = true;
        stopped = false;
        
        // Wait until something happens.
        while(!stopped) {
            [NSThread sleepForTimeInterval:500.0f];
        }
        
    }
    return 0;
}
