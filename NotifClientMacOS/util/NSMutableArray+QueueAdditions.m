//
//  NSMutableArray+QueueAdditions.m
//  NotifClientMacOS
//
//  Created by Wolfcow
//  http://stackoverflow.com/questions/817469/how-do-i-make-and-use-a-queue-in-objective-c
//

#import <Foundation/Foundation.h>
#import "NSMutableArray+QueueAdditions.h"

@implementation NSMutableArray (QueueAdditions)

- (id) dequeue {
    id headObject = [self objectAtIndex:0];
    if (headObject != nil) {
        [self removeObjectAtIndex:0];
    }
    return headObject;
}

- (void) enqueue:(id)anObject {
    [self addObject:anObject];
}

@end
