//
//  NSMutableArray+QueueAdditions.h
//  NotifClientMacOS
//
//  Created by Wolfcow
//  http://stackoverflow.com/questions/817469/how-do-i-make-and-use-a-queue-in-objective-c
//

#ifndef NotifClientMacOS_NSMutableArray_QueueAdditions_h
#define NotifClientMacOS_NSMutableArray_QueueAdditions_h

@interface NSMutableArray (QueueAdditions)

- (id) dequeue;
- (void) enqueue:(id)obj;

@end

#endif
