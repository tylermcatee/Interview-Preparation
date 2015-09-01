//
//  Concurrency.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/31/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "Concurrency.h"

@implementation Concurrency

+ (void)incrementEachItemInArrayByOne:(NSMutableArray *)numberArray {
    dispatch_apply(numberArray.count, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(size_t idx) {
        NSLog(@"%ld", (unsigned long)idx);
        NSNumber *original = numberArray[idx];
        original = @([original intValue] + 1);
        [numberArray setObject:original atIndexedSubscript:idx];
    });
}

@end
