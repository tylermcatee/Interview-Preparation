//
//  ListNode.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property (nonatomic, strong) NSObject<NSCopying> *obj;
@property (nonatomic, strong) ListNode *next;

// For some questions
@property (nonatomic, strong) ListNode *aux;

#pragma mark - Insertion

/**
 *  @method nodeWithObject:
 *  @discussion Creates a linked list with one object.
 */
+ (instancetype)nodeWithObject:(NSObject *)obj;

/**
 *  @method listFromArray:
 *  @discussion Takes an NSArray of NSObjects and builds
 *  a list from it.
 */
+ (instancetype)listFromArray:(NSArray *)array;

/**
 *  @method asArray
 *  @discussion Converts the list to an NSArray.
 */
- (NSArray *)asArray;

/**
 *  @method asReverseArray
 *  @discussion Converts the list to an NSArray but with the elements in reverse.
 */
- (NSArray *)asReverseArray;

/**
 *  @method pushFront:
 *  @discussion Inserts object in the front of the linked list.
 *  @returns The new ListNode created.
 */
- (ListNode *)pushFront:(NSObject *)obj;

/**
 *  @method pushBack:
 *  @discussion Inserts object in the back of the linked list.
 *  @returns The new ListNode created.
 */
- (ListNode *)pushBack:(NSObject *)obj;

/**
 *  @method insert:afterNode:
 *  @discussion Inserts an object after the specified node. If
 *  the specified node is nil, inserts at head.
 */
- (ListNode *)insert:(NSObject *)obj afterNode:(ListNode *)node;

@end
