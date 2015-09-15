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

+ (BOOL)sortedArray:(NSArray *)array contains:(NSNumber *)number {
    if (array.count < 1) {
        return NO;
    }
    return [[self class] _sortedArray:array contains:number between:0 and:array.count - 1];
}

+ (BOOL)_sortedArray:(NSArray *)array contains:(NSNumber *)number between:(NSUInteger)min and:(NSUInteger)max {
    NSInteger difference = max - min;
    if (difference < 0) {
        // Out of order
        return NO;
    }
    NSUInteger center = difference/2 + min;
    if ([array[center] isEqualToNumber:number]) {
        return YES; // Found it!
    } else if ([array[center] compare:number] == NSOrderedDescending) {
        // center > number, go left
        return [[self class] _sortedArray:array contains:number between:min and:center - 1];
    } else {
        // center < number go right
        return [[self class] _sortedArray:array contains:number between:center + 1 and:max];
    }
}

#define SECONDS_PER_MINUTE 60
#define MINUTES_PER_HOUR 60
#define HOURS_PER_DAY 24

+ (NSString *)timeStringForSecondsPastMidnight:(NSUInteger)seconds {
    // Make sure we're within a day
    while (seconds > SECONDS_PER_MINUTE * MINUTES_PER_HOUR * HOURS_PER_DAY) {
        seconds -= SECONDS_PER_MINUTE * MINUTES_PER_HOUR * HOURS_PER_DAY;
    }
    
    // Start by assuming it's AM
    BOOL isAM = YES;
    
    // First get the number of hours
    NSUInteger hours = seconds / (SECONDS_PER_MINUTE * MINUTES_PER_HOUR);
    seconds = seconds - hours * (SECONDS_PER_MINUTE * MINUTES_PER_HOUR);
    // Format the hour string
    if (hours == 0) {
        hours = 12;
    } else if (hours >= 12) {
        // No longer AM
        isAM = NO;
        if (hours != 12) {
            hours -= 12;
        }
    } else {
        
    }
    NSString *hourString = [NSString stringWithFormat:@"%02ld", (long)hours];
    
    // Second get the number of minutes
    NSUInteger minutes = seconds / SECONDS_PER_MINUTE;
    seconds = seconds - minutes * SECONDS_PER_MINUTE;
    // Format the minutes string
    NSString *minuteString = [NSString stringWithFormat:@"%02ld", (long)minutes];
    // Format the seconds string
    NSString *secondString = [NSString stringWithFormat:@"%02ld", (long)seconds];
    
    NSString *ampm = isAM ? @"AM" : @"PM";
    
    return [NSString stringWithFormat:@"%@:%@:%@%@", hourString, minuteString, secondString, ampm];
}

///////

// First we need to sort, use a merge sort

+ (NSArray *)mergeSort:(NSArray *)array {
    if ([array count] < 2) {
        return array;
    }
    NSRange leftRange = NSMakeRange(0, [array count]/2);
    NSRange rightRange = NSMakeRange([array count]/2, [array count] - [array count]/2);
    NSMutableArray *leftSorted = [[[self class] mergeSort:[array subarrayWithRange:leftRange]] mutableCopy];
    NSMutableArray *rightSorted = [[[self class] mergeSort:[array subarrayWithRange:rightRange]] mutableCopy];
    return [[self class] merge:leftSorted with:rightSorted];
}

+ (NSArray *)merge:(NSMutableArray *)leftArray with:(NSMutableArray *)rightArray {
    NSMutableArray *mutableArray = [NSMutableArray array];
    while ([leftArray count] > 0 && [rightArray count] > 0) {
        if ([[leftArray firstObject] compare:[rightArray firstObject]] == NSOrderedAscending) {
            // Left array smaller
            [mutableArray addObject:[leftArray firstObject]];
            [leftArray removeObject:[leftArray firstObject]];
        } else {
            // Right array smaller
            [mutableArray addObject:[rightArray firstObject]];
            [rightArray removeObject:[rightArray firstObject]];
        }
    }
    while ([leftArray count] > 0) {
        [mutableArray addObject:[leftArray firstObject]];
        [leftArray removeObject:[leftArray firstObject]];
    }
    while ([rightArray count] > 0) {
        [mutableArray addObject:[rightArray firstObject]];
        [rightArray removeObject:[rightArray firstObject]];
    }
    return mutableArray;
}

+ (BOOL)binarySearchOnArray:(NSArray *)array for:(NSUInteger)integer withMin:(NSUInteger)min andMax:(NSUInteger)max {
    if ([array count] == 0) {
        return NO;
    }
    NSInteger diff = max - min;
    if (diff < 0) {
        return NO;
    }
    NSUInteger center = min + diff/2;
    if ([array[center] integerValue] == integer) {
        return YES;
    } else if ([array[center] integerValue] < integer) {
        // Go right
        return [[self class] binarySearchOnArray:array for:integer withMin:center + 1 andMax:max];
    } else {
        // Go left
        return [[self class] binarySearchOnArray:array for:integer withMin:min andMax:center - 1];
    }
}

+ (NSUInteger)numberOfElementsIn:(NSArray *)array withDifference:(NSUInteger)difference {
    // O (n log n) sort
    NSArray *sortedArray = [[self class] mergeSort:array];
    NSUInteger result = 0;
    for (NSNumber *number in sortedArray) {
        if ([[self class] binarySearchOnArray:sortedArray
                                          for:[number integerValue] + difference
                                      withMin:0
                                       andMax:array.count - 1]) {
            result += 1;
        }
    }
    return result;
}

+ (BOOL)rectanglesOverlap:(CGRect)rect1 and:(CGRect)rect2 {
    CGFloat rect1_y1 = rect1.origin.y;
    CGFloat rect1_y2 = rect1.origin.y + rect1.size.height;
    CGFloat rect2_y1 = rect2.origin.y;
    CGFloat rect2_y2 = rect2.origin.y + rect2.size.height;
    
    if ((rect2_y1 > rect1_y1 && rect2_y1 > rect1_y2 && rect2_y2 > rect1_y1 && rect2_y2 > rect1_y2) || (rect2_y1 < rect1_y1 && rect2_y1 < rect1_y2 && rect2_y2 > rect1_y1 && rect2_y2 > rect1_y2)) {
        // Completely below or completely above the other rectangle
        return NO;
    }
    
    CGFloat rect1_x1 = rect1.origin.x;
    CGFloat rect1_x2 = rect1.origin.x + rect1.size.width;
    CGFloat rect2_x1 = rect2.origin.x;
    CGFloat rect2_x2 = rect2.origin.x + rect2.size.width;
    
    if ((rect2_x1 > rect1_x1 && rect2_x1 > rect1_x2 && rect2_x2 > rect1_x1 && rect2_x2 > rect1_x2) || (rect2_x1 < rect1_x1 && rect2_x1 < rect1_x2 && rect2_x2 < rect1_x1 && rect2_x2 < rect1_x2)) {
        // Completely to the left or completely to the right of the other rectangle
        return NO;
    }
    
    return YES;
}

@end
