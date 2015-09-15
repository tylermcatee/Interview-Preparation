//
//  Cache.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/4/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "Cache.h"

@interface Cache()

@property (nonatomic, readwrite) NSUInteger size;
// Ordered nodes
@property (nonatomic, strong) List *list;
// Map key -> Node
@property (nonatomic, strong) NSMutableDictionary *keys;

@end

@implementation Cache

+ (instancetype)cacheWithSize:(NSUInteger)size {
    Cache *cache = [[Cache alloc] init];
    cache.size = size;
    cache.keys = [NSMutableDictionary dictionaryWithCapacity:size];
    cache.list = [List new];
    return cache;
}

- (void)put:(id)value forKey:(NSString *)key {
    if (self.keys[key]) {
        [self.list deleteNode:self.keys[key]];
        [self.keys removeObjectForKey:key];
    }
    if ([[self.keys allKeys] count] == self.size) {
        // Need to delete tail
        [self.keys removeObjectForKey:self.list.tail.key];
        [self.list deleteNode:self.list.tail];
    }
    
    Node *newNodeForKey = [Node nodeWithObj:value andKey:key];
    [self.keys setObject:newNodeForKey forKey:key];
    [self.list pushFront:newNodeForKey];
}

- (id)get:(NSString *)key {
    if (self.keys[key]) {
        // Cache hit!
        Node *hitNode = self.keys[key];
        // Move to front if it's not already in the front
        if (self.list.head != hitNode) {
            [self.list deleteNode:hitNode];
            [self.list pushFront:hitNode];
        }
        return hitNode.obj;
    } else {
        // Cache miss!
        return nil;
    }
}

@end
