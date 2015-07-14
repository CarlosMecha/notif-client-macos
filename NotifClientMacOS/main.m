//
//  main.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/14/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"

Notification * parseResponse(NSDictionary * response) {
    NSString * uuid = [response valueForKey:@"uuid"];
    NSString * topic = [response valueForKey:@"topic"];
    NSString * timestamp = [response valueForKey:@"timestamp"];
    NSDictionary * payload = [response valueForKey:@"payload"];
    
    if(!uuid || !topic || !timestamp || !payload) {
        @throw [[NSError alloc] initWithDomain:@"notif-client.parse" code:((NSInteger) 1) userInfo:[response copy]];
    }
    
    Notification * notification = [[Notification alloc] initWithId:uuid];
    notification.timestamp = timestamp;
    notification.topic = topic;
    notification.payload = payload;
    
    return notification;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:@"http://localhost:3000/test?requeue=1"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSURLResponse * response = nil;
        NSError * error = nil;
        NSData * data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
        
        if (error == nil){
            
            id object = [NSJSONSerialization
                         JSONObjectWithData:data
                         options:0
                         error:&error];
            if([object isKindOfClass:[NSArray class]]) {
                NSLog(@"Success!! %@", parseResponse(((NSArray *) object)[0]));
            } else {
                NSLog(@"Class %@", [object className]);
            }
            
        } else {
            NSLog(@"Error!! %@", error);
        }
    }
    return 0;
}
