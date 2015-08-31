//
//  BinaryTree.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "BinaryTree.h"
#import "NSMutableArray+Stack.h"

@interface NSObject (Compare)
- (NSComparisonResult)compare:(NSObject *)obj;
@end

@interface BinaryTree()

@property (nonatomic, strong) BinaryTreeNode *root;

@end

@implementation BinaryTree

#pragma mark - Basic Functionality Recursively

- (void)insert:(NSObject *)obj {
    if (!self.root) {
        self.root = [BinaryTreeNode nodeWithObj:obj];
        return;
    } else {
        [self _insert:obj onNode:self.root];
    }
}

// Recursive helper function
- (void)_insert:(NSObject *)obj onNode:(BinaryTreeNode *)node {
    if ([node.obj compare:obj] == NSOrderedAscending) {
        // Node value < object value, need to go right
        if (node.rChild) {
            [self _insert:obj onNode:node.rChild];
        } else {
            node.rChild = [BinaryTreeNode nodeWithObj:obj];
        }
    } else {
        // Node value > object value, need to go left
        if (node.lChild) {
            [self _insert:obj onNode:node.lChild];
        } else {
            node.lChild = [BinaryTreeNode nodeWithObj:obj];
        }
    }
}

- (BOOL)contains:(NSObject *)obj {
    if (!self.root) {
        return NO;
    } else {
        return [self _contains:obj onNode:self.root];
    }
}

// Recursive helper function
- (BOOL)_contains:(NSObject *)obj onNode:(BinaryTreeNode *)node {
    if ([node.obj compare:obj] == NSOrderedSame) {
        return YES;
    } else if ([node.obj compare:obj] == NSOrderedAscending) {
        // Node value < object value, need to go right
        if (node.rChild) {
            return [self _contains:obj onNode:node.rChild];
        } else {
            return NO;
        }
    } else {
        // Node value > object value, need to go left
        if (node.lChild) {
            return [self _contains:obj onNode:node.lChild];
        } else {
            return NO;
        }
    }
}

- (BOOL)remove:(NSObject *)obj {
    // Case 1: No root, return no.
    if (!self.root) {
        return NO;
    } else {
        if ([obj compare:self.root.obj] == NSOrderedSame) {
            // Remove on root using dummy root method
            BinaryTreeNode *dummy = [BinaryTreeNode nodeWithObj:nil];
            dummy.lChild = self.root;
            BOOL result = [self _remove:obj onNode:self.root withParent:dummy];
            self.root = dummy.lChild;
            return result;
        } else {
            return [self _remove:obj onNode:self.root withParent:nil];
        }
    }
    
    return YES;
}


- (BOOL)_remove:(NSObject *)obj onNode:(BinaryTreeNode *)node withParent:(BinaryTreeNode *)parent {
    if ([obj compare:node.obj] == NSOrderedSame) {
        // Remove this!
        
        // CASE 1: Both Children
        if (node.lChild && node.rChild) {
            // We have two children, need to replace with the left max value
            node.obj = [self _maxValueOnNode:node.lChild];
            // And then search and destroy the old node
            [self _remove:node.obj onNode:node.lChild withParent:node];
        } else if (parent.lChild == node) {
            // We only have one child and we are the left child, make that child the replacement
            if (node.lChild) {
                parent.lChild = node.lChild;
            } else {
                parent.lChild = node.rChild;
            }
        } else {
            // We only have one child and we are the right child, make that child the replacement
            if (node.lChild) {
                parent.rChild = node.lChild;
            } else {
                parent.rChild = node.rChild;
            }
        }
        return YES;
    } else if ([node.obj compare:obj] == NSOrderedAscending) {
        // Node value < object value, need to go right
        if (node.rChild) {
            return [self _remove:obj onNode:node.rChild withParent:node];
        } else {
            return NO; // Not found!
        }
    } else {
        // Node value > object value, need to go left
        if (node.lChild) {
            return [self _remove:obj onNode:node.lChild withParent:node];
        } else {
            return NO; // Not found!
        }
    }
}

- (NSObject *)_maxValueOnNode:(BinaryTreeNode *)node {
    while (node.rChild) {
        node = node.rChild;
    }
    return node.obj;
}

#pragma mark - Traversal

- (NSArray *)inOrderRecursive {
    if (!self.root) {
        return @[]; // Base case
    }
    return [self _inOrderRecursiveOnNode:self.root];
}

- (NSArray *)_inOrderRecursiveOnNode:(BinaryTreeNode *)node {
    NSMutableArray *traversalArray = [NSMutableArray array];
    if (node.lChild) {
        [traversalArray addObjectsFromArray:[self _inOrderRecursiveOnNode:node.lChild]];
    }
    [traversalArray addObject:node.obj];
    if (node.rChild) {
        [traversalArray addObjectsFromArray:[self _inOrderRecursiveOnNode:node.rChild]];
    }
    return [traversalArray copy];
}

- (NSArray *)preOrderRecursive {
    if (!self.root) {
        return @[]; // Base case
    }
    return [self _preOrderRecursiveOnNode:self.root];
}

- (NSArray *)_preOrderRecursiveOnNode:(BinaryTreeNode *)node {
    NSMutableArray *traversalArray = [NSMutableArray array];
    [traversalArray addObject:node.obj];
    if (node.lChild) {
        [traversalArray addObjectsFromArray:[self _preOrderRecursiveOnNode:node.lChild]];
    }
    if (node.rChild) {
        [traversalArray addObjectsFromArray:[self _preOrderRecursiveOnNode:node.rChild]];
    }
    return [traversalArray copy];
}

- (NSArray *)postOrderRecursive {
    if (!self.root) {
        return @[]; // Base case
    }
    return [self _postOrderRecursiveOnNode:self.root];
}

- (NSArray *)_postOrderRecursiveOnNode:(BinaryTreeNode *)node {
    NSMutableArray *traversalArray = [NSMutableArray array];
    if (node.lChild) {
        [traversalArray addObjectsFromArray:[self _postOrderRecursiveOnNode:node.lChild]];
    }
    if (node.rChild) {
        [traversalArray addObjectsFromArray:[self _postOrderRecursiveOnNode:node.rChild]];
    }
    [traversalArray addObject:node.obj];
    return [traversalArray copy];
}

- (NSArray *)inOrder {
    // Our result array
    NSMutableArray *traversalArray = [NSMutableArray array];
    
    // A stack to go through the tree with
    NSMutableArray *stack = [NSMutableArray array];
    BinaryTreeNode *current = self.root;
    BOOL done = NO;
    
    while (!done) {
        if (current) {
            [stack push:current];
            current = current.lChild;
        } else {
            if (![stack isEmpty]) {
                current = [stack pop];
                [traversalArray addObject:current.obj];
                current = current.rChild;
            } else {
                done = YES;
            }
        }
    }
    return traversalArray;
}

- (NSArray *)preOrder {
    // Our result array
    NSMutableArray *traversalArray = [NSMutableArray array];
    
    NSMutableArray *stack = [NSMutableArray array];
    BinaryTreeNode *current = self.root;
    BOOL done = NO;
    
    while (!done) {
        if (current) {
            [traversalArray addObject:current.obj];
            [stack push:current];
            current = current.lChild;
        } else {
            if (![stack isEmpty]) {
                current = [stack pop];
                current = current.rChild;
            } else {
                done = YES;
            }
        }
    }
    
    return traversalArray;
}

- (NSArray *)postOrder {
    if (!self.root) return @[]; // Base case
    // Use a result stack
    NSMutableArray *resultStack = [NSMutableArray array];
    
    // A stack to iterate through the tree with
    NSMutableArray *stack = [NSMutableArray array];
    [stack push:self.root];
    
    while (![stack isEmpty]) {
        BinaryTreeNode *current = [stack pop];
        [resultStack push:current.obj];
        if (current.lChild) {
            [stack push:current.lChild];
        }
        if (current.rChild) {
            [stack push:current.rChild];
        }
    }
    
    return resultStack;
}

@end
