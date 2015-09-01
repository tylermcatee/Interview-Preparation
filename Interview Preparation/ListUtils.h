//
//  ListUtils.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListNode.h"

@interface ListUtils : NSObject

/**
 *  @method list:contains:
 *  @returns True if the list contains the object, false if not.
 */
+ (BOOL)list:(ListNode *)list contains:(NSObject *)obj;

/**
 *  @method listLength:
 *  @returns The number of nodes in the list.
 */
+ (NSUInteger)listLength:(ListNode *)list;

/**
 *  @method mthToLast:onList:
 *  @returns the Mth to last element in the list
 */
+ (NSObject *)mthToLast:(NSUInteger)m onList:(ListNode *)list;

/**
 *  @method sortListOfOnly)s1sAnd2s:
 *  @discussion The list must only contain 0, 1, and 2. We sort
 *  the list using O(N) time and O(1) memory.
 */
+ (void)sortListOfOnly0s1sAnd2s:(ListNode *)list;

/**
 *  @method repeatedlyDeleteM:afterN:onList:
 *  @discussion Move n nodes, then delete the next m, then skip n, then delete the next m,
 *  repeat until the end of the list.
 *  @returns The new head of the list, this is incase we need to delete the head.
 */
+ (ListNode *)repeatedlyDeleteM:(NSUInteger)n afterN:(NSUInteger)m onList:(ListNode *)list;

/**
 *  @method removeDuplicatesFromList:
 *  @discussion Removes duplicate nodes from the list.
 *  Do it in O(N) time with O(N) space.
 */
+ (void)removeDuplicatesFromList:(ListNode *)list;

/**
 *  @method removeDuplicatesFromListWithoutDictionary
 *  @discussion Removes duplicate nodes from the list without the use of a dictionary.
 *  Can do it in O(N^2) time without sorting, or O(N LogN) time with sorting.
 */
+ (void)removeDuplicatesFromListWithoutDictionary:(ListNode *)list;

/**
 *  @method reverseList:
 *  @returns The new list head.
 */
+ (ListNode *)reverseList:(ListNode *)list;

/**
 *  @method recursiveReverseList:
 *  @returns The new list head.
 */
+ (ListNode *)recursiveReverseList:(ListNode *)list;

/**
 *  @method reverseEveryKNodes:onList:
 *  @returns The new list head.
 */
+ (ListNode *)reverseEveryKNodes:(NSUInteger)k onList:(ListNode *)list;

/**
 *  @method listIsCircular:
 *  @returns YES if the linked list is circular, NO if not.
 */
+ (BOOL)listIsCircular:(ListNode *)list;

/**
 *  @method removeLoopOnList:
 *  @discussion Finds a loop in a list and removes it.
 */
+ (void)removeLoopOnList:(ListNode *)list;

/**
 *  @method mergeList:andList:
 *  @discussion Merges list1 and list2 using alternation.
 */
+ (ListNode *)mergeList:(ListNode *)list1 andList:(ListNode *)list2;

@end
