//
//  NSMutableArray+Stack.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "NSMutableArray+Stack.h"

@implementation NSMutableArray (Stack)

- (BOOL)isEmpty {
    return self.count == 0;
}

- (void)push:(id)obj {
    [self insertObject:obj atIndex:0];
}

- (id)pop {
    if ([self isEmpty]) {
        return nil;
    } else {
        id obj = [self firstObject];
        [self removeObjectAtIndex:0];
        return obj;
    }
}

@end
