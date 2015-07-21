//
//  TextDisplay.m
//  NotifClientMacOS
//
//  Created by Carlos Mecha on 7/21/15.
//  Copyright (c) 2015 Carlos Mecha. All rights reserved.
//

#import "TextDisplay.h"

@implementation TextDisplay

-(void) display:(Notification *)notification {
    printf("%s\n", [[notification description] UTF8String]);
}

@end
