//
//  ListNode.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "ListNode.h"

@implementation ListNode

+ (instancetype)nodeWithObject:(NSObject *)obj {
    ListNode *listNode = [[ListNode alloc] init];
    listNode.obj = obj;
    return listNode;
}

+ (instancetype)listFromArray:(NSArray *)array {
    ListNode *list;
    for (NSObject *obj in array) {
        if (list) {
            [list pushBack:obj];
        } else {
            list = [ListNode nodeWithObject:obj];
        }
    }
    return list;
}

#pragma mark - As Array

- (NSArray *)asArray {
    NSMutableArray *array = [NSMutableArray array];
    ListNode *cursor = self;
    while (cursor) {
        [array addObject:cursor.obj];
        cursor = cursor.next;
    }
    return [array copy];
}

#pragma mark - Insertion

- (ListNode *)pushFront:(NSObject *)obj {
    // Copy ourselves to a node after us, then change our obj value
    ListNode *newSecondary = [ListNode nodeWithObject:self.obj];
    newSecondary.next = self.next;
    self.next = newSecondary;
    self.obj = obj;
    return self;
}

- (ListNode *)pushBack:(NSObject *)obj {
    ListNode *cursor = self;
    while (cursor.next) {
        cursor = cursor.next;
    }
    cursor.next = [ListNode nodeWithObject:obj];
    return cursor.next;
}

- (ListNode *)insert:(NSObject *)obj afterNode:(ListNode *)node {
    if (!node) {
        // Insert in beginning!
        return [self pushFront:obj];
    }
    // Try to find node
    ListNode *cursor = self;
    while (cursor) {
        if (cursor == node) {
            break;
        }
        cursor = cursor.next;
    }
    if (!cursor) {
        return nil; // Couldn't find node.
    }
    // Found node, insert after it
    ListNode *newNode = [ListNode nodeWithObject:obj];
    newNode.next = cursor.next;
    cursor.next = newNode;
    return cursor.next;
}


@end
