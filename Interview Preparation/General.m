//
//  General.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "General.h"

@implementation General

+ (NSNumber *)firstRepeatedNumberInArray:(NSArray *)array {
    NSMutableDictionary *hash = [NSMutableDictionary dictionaryWithCapacity:array.count];
    for (NSNumber *number in array) {
        if (hash[number]) {
            return number;
        } else {
            hash[number] = number;
        }
    }
    return nil;
}

@end
