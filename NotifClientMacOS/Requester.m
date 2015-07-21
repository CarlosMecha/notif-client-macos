//
//  Requester.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/15/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import "Requester.h"
#import "displays/TextDisplay.h"

@implementation Requester

- (id) initWithUrl:(NSURL *)url interval:(NSTimeInterval)secs factory:(NotificationFactory *)factory {
    return [self initWithUrlAndDisplay:url interval:secs factory:factory display:nil];
}

- (id) initWithUrlAndDisplay:(NSURL *)url interval:(NSTimeInterval)secs factory:(NotificationFactory *)factory display :(NSObject<NotificationDisplay> *)display {
    self = [super init];
    if(self) {
        _secs = secs;
        _url = url;
        _factory = factory;
        _stopped = FALSE;
        if(display) {
            _display = display;
        } else {
            _display = [[TextDisplay alloc] init];
        }
    }
    return self;
    
}

- (void) stop {
    NSLog(@"Received an stop signal");
    _stopped = TRUE;
}

- (void) run {
    
    while (!_stopped) {
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
                        [_display display:notification];
                    }
                }
            } else {
                NSLog(@"The response wasn't an array. (Type %@)", [object className]);
            }
            
        } else {
            NSLog(@"Error %@ in request, retrying...", error);
        }
        
        // Sleep the interval.
        [NSThread sleepForTimeInterval:_secs];
        
    }
}

@end
