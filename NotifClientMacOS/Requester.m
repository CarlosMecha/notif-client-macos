//
//  Requester.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import "Requester.h"
#import "displays/TextDisplay.h"
#import "NSMutableArray+QueueAdditions.h"

const NSInteger DefaultBufferSize = 1024;
const NSTimeInterval DefaultInterval = 2.0f;

@implementation Requester

- (id) initWithUrl:(NSURL *)url factory:(NotificationFactory *)factory {
    return [self initWithUrlAndDisplay:url factory:factory display:nil];
}

- (id) initWithUrlAndDisplay:(NSURL *)url factory:(NotificationFactory *)factory display :(NSObject<NotificationDisplay> *)display {
    self = [super init];
    if(self) {
        _interval = DefaultInterval;
        _url = url;
        _factory = factory;
        _stopped = FALSE;
        if(display) {
            _display = display;
        } else {
            _display = [[TextDisplay alloc] init];
        }
        _bufferSize = DefaultBufferSize;
        _buffer = [[NSMutableArray alloc] initWithCapacity:_bufferSize];
    }
    return self;
    
}

- (void) stop {
    NSLog(@"Received an stop signal");
    _stopped = TRUE;
}

- (void) request {
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:_url];
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
            NSArray * results = (NSArray *) object;
            NSError * formatError = nil;
            
            for(id result in results) {
                Notification * notification = [_factory create: (NSDictionary *) result error:formatError];
                if(formatError) {
                    NSLog(@"Format error %@", formatError);
                } else {
                    [_buffer enqueue:notification];
                }
            }
        } else {
            NSLog(@"The response wasn't an array. (Type %@)", [object className]);
        }
        
    } else {
        NSLog(@"Error %@ in request, retrying...", error);
    }
    
}

- (void) displayNextNotification {
    Notification * notification = [_buffer dequeue];
    if(notification != nil) {
        [_display display:notification];
    }
}

- (void) run {
    
    while (!_stopped) {
        
        if([self bufferSize] > [_buffer count]) {
            [self request];
        }
     
        [self displayNextNotification];
        
        // Sleep the interval.
        [NSThread sleepForTimeInterval:[self interval]];
        
    }
}

@end
