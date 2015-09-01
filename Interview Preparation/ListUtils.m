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

+ (ListNode *)repeatedlyDeleteM:(NSUInteger)m afterN:(NSUInteger)n onList:(ListNode *)list {
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

+ (void)removeDuplicatesFromList:(ListNode *)list {
    ListNode *cursor = list;
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (list) {
        // Add the first element
        [dictionary setObject:list.obj forKey:list.obj];
    }
    while (cursor.next) {
        // Check for next so we can remove it
        if (dictionary[cursor.next.obj]) {
            // We need to remove next.
            cursor.next = cursor.next.next;
        } else {
            // Add to dictionary so we know we've seen it already
            [dictionary setObject:cursor.next.obj forKey:cursor.next.obj];
            cursor = cursor.next;
        }
    }
}

+ (void)removeDuplicatesFromListWithoutDictionary:(ListNode *)list {
    ListNode *cursor = list;
    while (cursor.next) {
        ListNode *itr = cursor;
        while (itr.next) {
            if ([itr.next.obj compare:cursor.obj] == NSOrderedSame) {
                // Delete itr.next
                itr.next = itr.next.next;
            } else {
                itr = itr.next;
            }
        }
        cursor = cursor.next;
    }
}

+ (ListNode *)reverseList:(ListNode *)list {
    if (!list) {
        return nil; // Empty list
    }
    if (!list.next) {
        return list; // Single node
    }
    ListNode *cursor, *prev, *next;
    cursor = list;
    while (cursor) {
        next = cursor.next;
        cursor.next = prev;
        prev = cursor;
        cursor = next;
    }
    return prev;
}

+ (ListNode *)recursiveReverseList:(ListNode *)list {
    if (!list) {
        return nil; // Empty list
    }
    if (!list.next) {
        return list; // Single node
    }
    // Grab the rest of the list
    ListNode *next = list.next;
    // Unlink this node
    list.next = nil;
    // Reverse the rest of the list and grab the new head
    ListNode *newHead = [[self class] recursiveReverseList:next];
    // Re-link this node
    next.next = list;
    // Return the head
    return newHead;
}

+ (ListNode *)reverseEveryKNodes:(NSUInteger)k onList:(ListNode *)list {
    if (!list) {
        return nil; // Empty list
    }
    if (!list.next) {
        return list; // Single list
    }
    ListNode *current = list;
    ListNode *prev, *next;
    NSUInteger count = 0;
    while (current && count < k) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
        count++;
    }
    list.next = [[self class] reverseEveryKNodes:k onList:next];
    return prev;
}

+ (BOOL)listIsCircular:(ListNode *)list {
    ListNode *slow;
    ListNode *fast;
    slow = list;
    fast = list;
    while (fast) {
        if (fast.next.next) {
            fast = fast.next.next;
            slow = slow.next;
        } else {
            // fast.next.next is nil, list is non-circular
            return NO;
        }
        if (fast == slow) {
            return YES;
        }
    }
    return NO;
}

+ (void)removeLoopOnList:(ListNode *)list {
    ListNode *turtle, *rabbit;
    turtle = list, rabbit = list;
    while (rabbit) {
        rabbit = rabbit.next;
        if (rabbit) {
            if (rabbit.next == turtle) {
                rabbit.next = nil;
                return;
            } else {
                rabbit = rabbit.next;
            }
            turtle = turtle.next;
        }
    }
}

+ (ListNode *)mergeList:(ListNode *)list1 andList:(ListNode *)list2 {
    
    if (!list1) {
        return list2;
    }
    
    ListNode *cursor1 = list1;
    ListNode *cursor2 = list2;
    
    while (cursor1 && cursor2) {
        // Remember the cursor 2 next
        ListNode *temp = cursor2.next;
        // cursor 2 next -> cursor 1 next
        cursor2.next = cursor1.next;
        // cursor 1 next -> cursor 2
        cursor1.next = cursor2;
        // Move cursor 1 to the new next
        if (cursor2.next) {
            cursor1 = cursor2.next;
        } else {
            // List 1 is done now, tack on the rest of list 2
            cursor2.next = temp;
            return list1;
        }
        // Move cursor 2 to the original next
        cursor2 = temp;
    }
    
    if (cursor2) {
        // Add the remaining list to the end of cursor 1
        cursor1.next = cursor2;
    }
    return list1;
}

@end
