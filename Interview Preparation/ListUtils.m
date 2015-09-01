//
//  ListUtils.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "ListUtils.h"
#import "NSObject+Compare.h"

@implementation ListUtils

+ (BOOL)list:(ListNode *)list contains:(NSObject *)obj {
    if (!list) {
        return NO; // Base case: Empty
    }
    ListNode *cursor = list;
    while (cursor) {
        if ([cursor.obj compare:obj] == NSOrderedSame) {
            return YES;
        }
        cursor = cursor.next;
    }
    return NO;
}

+ (NSUInteger)listLength:(ListNode *)list {
    if (!list) {
        return 0;
    }
    NSUInteger length = 0;
    ListNode *cursor = list;
    while (cursor) {
        length += 1;
        cursor = cursor.next;
    }
    return length;
}

+ (NSObject *)mthToLast:(NSUInteger)m onList:(ListNode *)list {
    ListNode *cursor = list;
    ListNode *mthToLast = list;
    while (m > 0 && cursor) {
        cursor = cursor.next;
        m--;
    }
    if (m > 0 || cursor == nil) {
        return nil; // Not m elements in list
    }
    // Advance cursor to end with mthToLast pointer following
    while (cursor.next) {
        cursor = cursor.next;
        mthToLast = mthToLast.next;
    }
    return mthToLast.obj;
}

+ (void)sortListOfOnly0s1sAnd2s:(ListNode *)list {
    // First step is going through the list and counting the elements
    NSUInteger num0s = 0, num1s = 0;
    
    ListNode *cursor = list;
    while (cursor) {
        if ([cursor.obj isEqual:@0]) {
            num0s++;
        } else if ([cursor.obj isEqual:@1]) {
            num1s++;
        } else {
            // Just assuming that the list is correct as specified in question
            // So we don't even need to count 2s
        }
        cursor = cursor.next;
    }
    // Now we go back through the list and change all the values
    cursor = list;
    while (cursor) {
        if (num0s > 0) {
            cursor.obj = @0;
            num0s--;
        } else if (num1s > 0) {
            cursor.obj = @1;
            num1s--;
        } else {
            cursor.obj = @2;
        }
        cursor = cursor.next;
    }
}

+ (ListNode *)repeatedlyDeleteN:(NSUInteger)n afterM:(NSUInteger)m onList:(ListNode *)list {
    ListNode *head = list;
    /*
     Edge cases:
     Deleting the first node
     Deleting the last node
     Hitting the end of the list in the middle of either n or m
     */
    ListNode *cursor = list;
    ListNode *prev = nil;
    NSUInteger nCursor = n;
    NSUInteger mCursor = m;
    while (cursor) {
        // If we are counting n over, just move next
        if (nCursor > 0) {
            nCursor--;
            prev = cursor;
            cursor = cursor.next;
        } else if (mCursor > 0) {
            mCursor--;
            // Need to delete this node!
            if (prev) {
                // Just move the previous pointer up
                prev.next = cursor.next;
            } else {
                // We are deleting the head, just move head.
                head = cursor.next;
            }
            cursor = cursor.next;
        } else {
            // We counted n and deleted m, reset the counters.
            nCursor = n;
            mCursor = m;
        }
    }
    return head;
}

@end
