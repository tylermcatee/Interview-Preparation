//
//  Arrays.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "Arrays.h"

// 1 2 3 4 5 6 7
// 1 5 3 4 2 6 7

@implementation Arrays

+ (NSArray *)singleSwapSort:(NSArray *)array {
    for (NSUInteger i = 0; i < array.count - 1; i++) {
        // Look for the first element that is greater than the next.
        if (array[i] > array[i + 1]) {
            // out of order!
            NSUInteger j = i + 1;
            while (j < array.count && array[j] < array[i]) {
                j++;
            }
            // Then we swap i and j - 1
            return [[self class] array:array bySwapping:j - 1 and:i];
        }
    }
    return @[];
}

+ (NSArray *)array:(NSArray *)array bySwapping:(NSUInteger)i and:(NSUInteger)j {
    NSMutableArray *mutableCopy = [array mutableCopy];
    NSNumber *temp = mutableCopy[i];
    mutableCopy[i] = mutableCopy[j];
    mutableCopy[j] = temp;
    return mutableCopy;
}

/*
 There are two approaches to this. The brute force solution is O(N^2) where we
 go ahead and look at each number and its difference with every other number in the
 array. This is two for loops.
 
 The second solution is O(N*LogN) which involves sorting the array, then looking at each number
 and doing a binary search for that number + k in the rest of the array.
 */
+ (NSUInteger)pairsOfNumbersInArray:(NSArray *)array withDifference:(NSInteger)difference {
//    return [[self class] _bruteForce_pairsOfNumbersInArray:array withDifference:difference];
    return [[self class] _sorting_pairsOfNumbersInArray:array withDifference:difference];
}

// BINARY SEARCH
+ (BOOL)array:(NSArray *)array contains:(NSNumber *)number {
    return [[self class] array:array contains:number between:0 and:array.count - 1];
}
+ (BOOL)array:(NSArray *)array contains:(NSNumber *)number between:(NSUInteger)min and:(NSInteger)max {
    if (min > max) {
        return NO;
    }
    NSUInteger diff = max - min;
    NSUInteger center = diff/2. + min;
    if ([array[center] isEqualToNumber:number]) {
        return YES;
    } else if (array[center] > number) {
        return [[self class] array:array contains:number between:min and:center - 1];
    } else {
        return [[self class] array:array contains:number between:center + 1 and:max];
    }
}

+ (NSUInteger)_sorting_pairsOfNumbersInArray:(NSArray *)array withDifference:(NSInteger)difference {
    // Just use a built in sort
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < array.count; i++) {
        if ([[self class] array:sortedArray contains:@([array[i] intValue] + difference)]) {
            count++;
        }
    }
    return count;
}

+ (NSUInteger)_bruteForce_pairsOfNumbersInArray:(NSArray *)array withDifference:(NSInteger)difference {
    NSUInteger count = 0;
    for (NSUInteger i = 0; i < array.count; i++) {
        for (NSUInteger j = i + 1; j < array.count; j++) {
            if (abs([array[i] intValue] - [array[j] intValue]) == difference) {
                count++;
            }
        }
    }
    return count;
}

+ (NSArray *)mergeSortArray:(NSArray *)array {
    // Base case: Already sorted
    if (array.count < 2) {
        return array;
    }
    NSUInteger center = array.count/2;
    NSRange leftRange = NSMakeRange(0, center);
    NSRange rightRange = NSMakeRange(center, array.count - center);
    NSArray *leftArray = [array subarrayWithRange:leftRange];
    NSArray *rightArray = [array subarrayWithRange:rightRange];
    return [[self class] merge:[[self class] mergeSortArray:leftArray] andRight:[[self class] mergeSortArray:rightArray]];
}

+ (NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr {
    NSMutableArray *result = [NSMutableArray array];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count]) {
        if (leftArr[left] < rightArr[right]) {
            [result addObject:leftArr[left]];
            left++;
        } else {
            [result addObject:rightArr[right]];
            right++;
        }
    }
    while (left < [leftArr count]) {
        [result addObject:leftArr[left]];
        left++;
    }
    while (right < [rightArr count]) {
        [result addObject:rightArr[right]];
        right++;
    }
    return result;
}

+ (NSUInteger)minimumDistanceBetweenElementsOfArray:(NSArray *)array {
    // N * LogN time
    NSArray *sortedArray = [self mergeSortArray:array];
    // N time
    NSUInteger minimumDistance = INT32_MAX;
    for (NSUInteger i = 0; i < sortedArray.count - 1; i++) {
        NSUInteger diff = [sortedArray[i + 1] intValue] - [sortedArray[i] intValue];
        if (diff < minimumDistance) {
            minimumDistance = diff;
        }
    }
    return minimumDistance;
}

@end
