//
//  Heap.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/3/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Heap : NSObject

/**
 *  @discussion Returns a min heap.
 */
+ (instancetype)minHeap;

/**
  * @discussion Returns a max heap.
 */
+ (instancetype)maxHeap;

/**
 *  @method pushHeap:
 *  @discussion Inserts a NSNumber into the heap.
 */
- (void)pushHeap:(NSNumber *)number;

/**
 *  @method headElement
 *  @discussion Returns the top element in the heap.
 */
- (NSNumber *)headElement;

/**
 *  @method popHeap
 *  @discussion Removes the min/max element from the heap (depending on whether this is a min or max heap).
 */
- (NSNumber *)popHeap;

/**
 *  @method isEmpty
 *  @returns YES if the heap has no elements, NO if it has at least one element.
 */
- (BOOL)isEmpty;

/**
 *  @method sortedArray:usingSmallestToLargest:
 *  @param array An NSArray of NSNumbers.
 *  @param smallestToLargest Whether to sort the array from smallest to largest, or largest to smallest.
 *  @discussion Returns a sorted version of array using heap sort.
 */
+ (NSArray *)sortedArray:(NSArray *)array usingSmallestToLargest:(BOOL)smallestToLargest;

@end
