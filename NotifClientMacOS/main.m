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

void stop() {
    NSLog(@"Received shutdown order.");
    
    if(requester) {
        [requester stop];
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if(argc != 2) {
            NSLog(@"Usage: notifications <url>");
            return 1;
        }
        
        signal(SIGINT, stop);
        
        NSString * url = [NSString stringWithFormat:@"%s", argv[1]];
        NSURL * requestUrl = [NSURL URLWithString:url];
        
        Formatter * formatter = [[Formatter alloc] init];
        requester = [[Requester alloc] initWithUrl:requestUrl interval:2.0f formatter:formatter];
        
        [requester run];
        
    }
    return 0;
}
