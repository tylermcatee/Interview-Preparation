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
 *  @method repeatedlyDeleteN:afterM:onList:
 *  @discussion Move n nodes, then delete the next m, then skip n, then delete the next m,
 *  repeat until the end of the list.
 *  @returns The new head of the list, this is incase we need to delete the head.
 */
+ (ListNode *)repeatedlyDeleteN:(NSUInteger)n afterM:(NSUInteger)m onList:(ListNode *)list;

@end
