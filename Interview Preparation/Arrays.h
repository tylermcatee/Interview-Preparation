//
//  Arrays.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Arrays : NSObject

/**
 *  @method singleSwapSort:
 *  @discussion Sort an almost sorted array where only two elements are swapped
 */
+ (NSArray *)singleSwapSort:(NSArray *)array;

/**
 *  @method pairsOfNumbersInArray:withDifference:
 *  @discussion Returns the number of pairs in the array with the given difference.
 */
+ (NSUInteger)pairsOfNumbersInArray:(NSArray *)array withDifference:(NSInteger)difference;

/**
 *  @method array:contains:
 *  @discussion Implement a binary search.
 */
+ (BOOL)array:(NSArray *)array contains:(NSNumber *)number;

/**
 *  @method mergeSortArray:
 *  @discussion Does merge sort on array.
 */
+ (NSArray *)mergeSortArray:(NSArray *)array;

/**
 *  @method minimumDistanceBetweenElementsOfArray:
 *  @discussion Given an array that may not be sorted, find the minimum distance
 *  between two elements in O(NLogN) time.
 */
+ (NSUInteger)minimumDistanceBetweenElementsOfArray:(NSArray *)array;

@end
