//
//  Heap.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/3/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "Heap.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeapType) {
    HeapTypeMin,
    HeapTypeMax
};

@interface Heap()

@property (nonatomic, strong) NSMutableArray *mutableArray;
@property (nonatomic) HeapType heapType;

@end

@implementation Heap

#pragma mark - Initialization

+ (instancetype)minHeap {
    Heap *heap = [[Heap alloc] init];
    heap.heapType = HeapTypeMin;
    return heap;
}

+ (instancetype)maxHeap {
    Heap *heap = [[Heap alloc] init];
    heap.heapType = HeapTypeMax;
    return heap;
}

- (NSComparisonResult)heapCompare:(NSNumber *)number with:(NSNumber *)otherNumber {
    if (self.heapType == HeapTypeMin) {
        return [number compare:otherNumber];
    } else {
        return [otherNumber compare:number];
    }
}

- (NSMutableArray *)mutableArray {
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

#pragma mark - Tree methods

- (NSUInteger)parentIndexOf:(NSUInteger)childIndex {
    if (childIndex <= 0) {
        return NSNotFound; // Special case for finding parent of root.
    }
    return childIndex/2; // (2n + 1)/2 and (2n)/2 are both n
}

- (BOOL)isEmpty {
    return self.mutableArray.count == 0;
}

#pragma mark - Insertion

- (void)upHeap {
    // Moves the last element up through the heap as necessary
    NSUInteger childIndex = self.mutableArray.count - 1;
    NSUInteger parentIndex = [self parentIndexOf:childIndex];
    while (parentIndex != NSNotFound && [self heapCompare:self.mutableArray[childIndex] with:self.mutableArray[parentIndex]] == NSOrderedAscending) {
        NSNumber *temp = self.mutableArray[childIndex];
        self.mutableArray[childIndex] = self.mutableArray[parentIndex];
        self.mutableArray[parentIndex] = temp;
        childIndex = parentIndex;
        parentIndex = [self parentIndexOf:childIndex];
    }
}

- (void)pushHeap:(NSNumber *)number {
    [self.mutableArray addObject:number];
    [self upHeap];
}

#pragma mark - Looking at head

- (NSNumber *)headElement {
    return [self.mutableArray firstObject];
}

#pragma mark - Removing

- (void)downHeap {
    // Moves down the last element
    NSUInteger parentIndex = 0;
    NSUInteger childIndex2 = (parentIndex + 1)*2;
    NSUInteger childIndex1 = childIndex2 - 1;
    while (parentIndex < self.mutableArray.count) {
        NSUInteger maxChildIndex;
        if (childIndex2 < self.mutableArray.count) {
            // We have both children, which one is best to swap with
            if ([self heapCompare:self.mutableArray[childIndex1] with:self.mutableArray[childIndex2]] == NSOrderedAscending) {
                maxChildIndex = childIndex1; // Which one?
            } else {
                maxChildIndex = childIndex2;
            }
        } else {
            if (childIndex1 < self.mutableArray.count) {
                // We have only one child
                maxChildIndex = childIndex1;
            } else {
                // No children, done
                return;
            }
        }
        
        // Now compare with the parent index
        if ([self heapCompare:self.mutableArray[parentIndex] with:self.mutableArray[maxChildIndex]] == NSOrderedDescending) {
            // Do the swap!
            NSNumber *temp = self.mutableArray[parentIndex];
            self.mutableArray[parentIndex] = self.mutableArray[maxChildIndex];
            self.mutableArray[maxChildIndex] = temp;
            parentIndex = maxChildIndex;
            childIndex2 = (parentIndex + 1)*2;
            childIndex1 = childIndex2 - 1;
        } else {
            return;
        }
    }
}

- (NSNumber *)popHeap {
    NSNumber *head = [self.mutableArray firstObject];
    if (head) {
        NSNumber *tail = [self.mutableArray lastObject];
        if (head != tail) {
            // Set the head value to be the tail
            self.mutableArray[0] = tail;
            // Remove the tail
            [self.mutableArray removeObjectAtIndex:self.mutableArray.count - 1];
            // Down heap
            [self downHeap];
        } else {
            [self.mutableArray removeObject:head];
        }
    }
    return head;
}

#pragma mark - Sorting

+ (NSArray *)sortedArray:(NSArray *)array usingSmallestToLargest:(BOOL)smallestToLargest {
    Heap *heap;
    if (smallestToLargest) {
        heap = [Heap minHeap];
    } else {
        heap = [Heap maxHeap];
    }
    for (NSNumber *number in array) {
        [heap pushHeap:number];
    }
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    while (![heap isEmpty]) {
        [result addObject:[heap popHeap]];
    }
    return result;
}

@end
