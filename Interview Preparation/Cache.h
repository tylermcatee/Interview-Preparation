//
//  Cache.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/4/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

// Underlying implementation of cache is doubly linked list
@interface Node : NSObject
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) Node *next;
@property (nonatomic, strong) Node *prev;
+ (instancetype)nodeWithObj:(id)obj andKey:(NSString *)key;
@end
@implementation Node
+ (instancetype)nodeWithObj:(id)obj andKey:(NSString *)key {
    Node *node = [Node new];
    node.obj = obj;
    node.key = key;
    return node;
}
@end
@interface List : NSObject
@property (nonatomic, strong) Node *head;
@property (nonatomic, strong) Node *tail;
// For the cache implementation we only need to push front and delete node.
- (void)pushFront:(Node *)node;
- (void)deleteNode:(Node *)node;
@end
@implementation List
- (void)pushFront:(Node *)node {
    if (self.head) {
        node.prev = nil;
        node.next = self.head;
        self.head.prev = node;
        self.head = node;
    } else {
        self.head = node;
        self.tail = node;
    }
}
- (void)deleteNode:(Node *)node {
    if (node == self.head) {
        if (self.head.next) {
            self.head.next.prev = nil;
            self.head = self.head.next;
        } else {
            self.tail = nil;
            self.head = nil;
        }
    } else {
        Node *cursor = self.head;
        while (cursor != node) {
            // ASSUME WE FIND IT
            cursor = cursor.next;
        }
        if (cursor.next) {
            cursor.next.prev = cursor.prev;
        } else {
            // It's the tail!
            self.tail = cursor.prev;
        }
        // Even if cursor.next is nil this is okay.
        cursor.prev.next = cursor.next;
    }
}
@end

@interface Cache : NSObject

// FOR DEBUG
@property (readonly) List *list;

+ (instancetype)cacheWithSize:(NSUInteger)size;

@property (nonatomic, readonly) NSUInteger size;

/**
 *  @method get:
 *  @returns The value if it is in the cache, and nil if it is
 *  a cache miss.
 */
- (id)get:(NSString *)key;

/**
 *  @method put:forKey:
 *  @discussion inserts a value into the cache.
 */
- (void)put:(id)value forKey:(NSString *)key;

@end
