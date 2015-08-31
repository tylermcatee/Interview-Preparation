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

#pragma mark - Equality

- (BOOL)isEqual:(BinaryTree *)tree {
    return [self _node:self.root isEqualToNode:tree.root];
}

- (BOOL)_node:(BinaryTreeNode *)node isEqualToNode:(BinaryTreeNode *)otherNode {
    
    // Check for nil cases
    if (otherNode && !node) {
        return NO;
    } else if (!otherNode && node) {
        return NO;
    } else if (!otherNode && !node) {
        return YES;
    }
    
    if (![node.obj compare:otherNode.obj] == NSOrderedSame) {
        return NO;
    }
    
    return [self _node:node.lChild isEqualToNode:otherNode.lChild] && [self _node:node.rChild isEqualToNode:otherNode.rChild];
}

#pragma mark - Verification

- (BOOL)isBinarySearchTree {
    // Stack
    NSMutableArray *stack = [NSMutableArray array];
    BinaryTreeNode *current = self.root;
    BinaryTreeNode *previous = nil;
    BOOL done = NO;
    while (!done) {
        if (current) {
            [stack push:current];
            current = current.lChild;
        } else {
            if (![stack isEmpty]) {
                current = [stack pop];
                if (previous) {
                    if ([previous.obj compare:current.obj] == NSOrderedDescending) {
                        return NO; // Not a binary search tree!
                    }
                }
                previous = current;
                current = current.rChild;
            } else {
                // Done!
                done = YES;
            }
        }
    }
    return YES;
}

#pragma mark - Interview Questions

- (BinaryTreeNode *)nextHighestNodeThan:(BinaryTreeNode *)node {
    NSMutableArray *stack = [NSMutableArray array];
    BinaryTreeNode *cursor = self.root;
    while (cursor) {
        if ([cursor isEqual:node]) {
            // We found the goal node!
            if (cursor.rChild) {
                // If it has a right child, that will be the next highest
                return cursor.rChild;
            } else {
                // No r child, check the parents for the first one higher than this node
                BinaryTreeNode *result;
                while (![stack isEmpty]) {
                    result = [stack pop];
                    if ([result.obj compare:node.obj] == NSOrderedDescending) {
                        return result;
                    }
                }
                return nil; // Not found
            }
        } else if ([cursor.obj compare:node.obj] == NSOrderedDescending) {
            // Cursor.obj > node.obj, need to look left
            [stack push:cursor];
            cursor = cursor.lChild;
        } else {
            // Cursor.obj < node.obj, need to look right
            [stack push:cursor];
            cursor = cursor.rChild;
        }
    }
    return nil; // Not Found
}

- (BinaryTreeNode *)smallest {
    if (self.root) {
        BinaryTreeNode *smallest = self.root;
        while (smallest.lChild) {
            smallest = smallest.lChild;
        }
        return smallest;
    } else {
        return nil;
    }
}

- (BinaryTreeNode *)largest {
    if (self.root) {
        BinaryTreeNode *largest = self.root;
        while (largest.rChild) {
            largest = largest.rChild;
        }
        return largest;
    } else {
        return nil;
    }
}

- (BinaryTreeNode *)lowestCommonAncestorToNode:(BinaryTreeNode *)node andOtherNode:(BinaryTreeNode *)otherNode {
    BinaryTreeNode *cursor = self.root;
    while (cursor) {
        // If both nodes are less than cursor, move left
        if ([node.obj compare:cursor.obj] == NSOrderedAscending && [otherNode.obj compare:cursor.obj] == NSOrderedAscending) {
            cursor = cursor.lChild;
        } else if ([node.obj compare:cursor.obj] == NSOrderedDescending && [otherNode.obj compare:cursor.obj] == NSOrderedDescending) {
            cursor = cursor.rChild;
        } else {
            return cursor;
        }
    }
    // Bad case
    return nil;
}

- (BOOL)node:(BinaryTreeNode *)node isCousinOfNode:(BinaryTreeNode *)otherNode {
    // Get the height and parents of both nodes
    BinaryTreeNode *cursor, *parent, *otherParent;
    NSInteger depth = 0, otherDepth = 0;
    
    cursor = self.root;
    while (cursor) {
        if ([cursor.obj compare:node.obj] == NSOrderedDescending) {
            // cursor.obj > node.obj, move left
            parent = cursor;
            cursor = cursor.lChild;
            depth += 1;
        } else if ([cursor.obj compare:node.obj] == NSOrderedAscending) {
            // cursor.obj < node.obj, move right
            parent = cursor;
            cursor = cursor.rChild;
            depth += 1;
        } else {
            break;
        }
    }
    
    cursor = self.root;
    while (cursor) {
        if ([cursor.obj compare:otherNode.obj] == NSOrderedDescending) {
            // cursor.obj > node.obj, move left
            otherParent = cursor;
            cursor = cursor.lChild;
            otherDepth += 1;
        } else if ([cursor.obj compare:otherNode.obj] == NSOrderedAscending) {
            // cursor.obj < node.obj, move right
            otherParent = cursor;
            cursor = cursor.rChild;
            otherDepth += 1;
        } else {
            break;
        }
    }
    
    if (depth != otherDepth) {
        return NO;
    }
    if ([parent isEqual:otherParent]) {
        return NO;
    }
    return YES;
}

- (NSArray *)spiralTraversal:(BOOL)leftFirst {
    if (!self.root) {
        return @[]; // Base case
    }
    NSMutableArray *result = [NSMutableArray array];
    NSMutableArray *stack1 = [NSMutableArray array];
    NSMutableArray *stack2 = [NSMutableArray array];
    
    if (leftFirst) {
        [stack1 push:self.root];
    } else {
        [stack2 push:self.root];
    }
    
    while (![stack1 isEmpty] || ![stack2 isEmpty]) {
        
        while (![stack1 isEmpty]) {
            BinaryTreeNode *node = [stack1 pop];
            [result addObject:node.obj];
            if (node.rChild) {
                [stack2 push:node.rChild];
            }
            if (node.lChild) {
                [stack2 push:node.lChild];
            }
        }
        
        while (![stack2 isEmpty]) {
            BinaryTreeNode *node = [stack2 pop];
            [result addObject:node.obj];
            if (node.lChild) {
                [stack1 push:node.lChild];
            }
            if (node.rChild) {
                [stack1 push:node.rChild];
            }
        }
    }
    return result;
}

- (NSArray *)spiralTraversalRecursive:(BOOL)leftFirst {
    NSUInteger level = 1;
    NSMutableArray *result = [NSMutableArray array];
    while (true) {
        NSArray *spiralLevel = [self _spiralLevelOnNode:self.root withLevel:level andAlt:leftFirst];
        if (spiralLevel.count == 0) {
            return result;
        }
        [result addObjectsFromArray:spiralLevel];
        level += 1;
        leftFirst = !leftFirst;
    }
}

- (NSArray *)_spiralLevelOnNode:(BinaryTreeNode *)node withLevel:(NSUInteger)level andAlt:(BOOL)alt {
    if (!node) {
        return @[];
    }
    if (level == 1) {
        return @[node.obj];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    if (alt) {
        [result addObjectsFromArray:[self _spiralLevelOnNode:node.rChild withLevel:level-1 andAlt:alt]];
        [result addObjectsFromArray:[self _spiralLevelOnNode:node.lChild withLevel:level-1 andAlt:alt]];
    } else {
        [result addObjectsFromArray:[self _spiralLevelOnNode:node.lChild withLevel:level-1 andAlt:alt]];
        [result addObjectsFromArray:[self _spiralLevelOnNode:node.rChild withLevel:level-1 andAlt:alt]];
    }
    return result;
}

- (NSArray *)levelTraversal {
    NSMutableArray *queue = [NSMutableArray array];
    NSMutableArray *result = [NSMutableArray array];
    if (self.root) {
        [queue addObject:self.root];
    }
    while (queue.count > 0) {
        BinaryTreeNode *node = [queue firstObject];
        [queue removeObject:node];
        [result addObject:node.obj];
        if (node.lChild) {
            [queue addObject:node.lChild];
        }
        if (node.rChild) {
            [queue addObject:node.rChild];
        }
    }
    return result;
}

- (NSArray *)levelTraversalRecursive {
    NSUInteger level = 1;
    NSMutableArray *result = [NSMutableArray array];
    while (true) {
        NSArray *levelList = [self _levelTraversalOnNode:self.root withLevel:level];
        if (levelList.count == 0) {
            return result;
        }
        [result addObjectsFromArray:levelList];
        level += 1;
    }
}

- (NSArray *)_levelTraversalOnNode:(BinaryTreeNode *)node withLevel:(NSUInteger)level {
    if (!node) {
        return @[];
    }
    if (level == 1) {
        return @[node.obj];
    }
    NSMutableArray *result = [NSMutableArray array];
    [result addObjectsFromArray:[self _levelTraversalOnNode:node.lChild withLevel:level-1]];
    [result addObjectsFromArray:[self _levelTraversalOnNode:node.rChild withLevel:level-1]];
    return result;
}

- (NSArray *)elementsGreaterThan:(NSObject *)minimum andSmallerThan:(NSObject *)maximum {
    if (!self.root) {
        return @[]; // Base case
    }
    return [self _elementsGreaterThan:minimum andSmallerThan:maximum onNode:self.root];
}

- (NSArray *)_elementsGreaterThan:(NSObject *)minimum andSmallerThan:(NSObject *)maximum onNode:(BinaryTreeNode *)node {
    NSMutableArray *result = [NSMutableArray array];
    BOOL nodeGreaterThanMinimum = ([node.obj compare:minimum] == NSOrderedDescending);
    BOOL nodeLessThanMaximum = ([node.obj compare:maximum] == NSOrderedAscending);
    
    if (node.lChild) {
        // Only go left if we're still greater than minimum
        if (nodeGreaterThanMinimum) {
            [result addObjectsFromArray:[self _elementsGreaterThan:minimum andSmallerThan:maximum onNode:node.lChild]];
        }
    }
    
    if (nodeGreaterThanMinimum && nodeLessThanMaximum) {
        // Node.obj is between minimum and maximum, add to result
        [result addObject:node.obj];
    }
    
    if (node.rChild) {
        // Only go right if we're still less than maximum
        if (nodeLessThanMaximum) {
            [result addObjectsFromArray:[self _elementsGreaterThan:minimum andSmallerThan:maximum onNode:node.rChild]];
        }
    }
    return result;
}

- (void)deleteLeaves {
    // If root is nil
    if (!self.root) {
        return;
    }
    // If root is leaf
    if ([self nodeIsLeaf:self.root]) {
        self.root = nil;
        return;
    }
    // Otherwise
    [self _deleteLeavesOnNode:self.root];
}

- (BOOL)nodeIsLeaf:(BinaryTreeNode *)node {
    return !node.lChild && !node.rChild;
}

- (void)_deleteLeavesOnNode:(BinaryTreeNode *)node {
    if (node.lChild) {
        if ([self nodeIsLeaf:node.lChild]) {
            node.lChild = nil;
        } else {
            [self _deleteLeavesOnNode:node.lChild];
        }
    }
    if (node.rChild) {
        if ([self nodeIsLeaf:node.rChild]) {
            node.rChild = nil;
        } else {
            [self _deleteLeavesOnNode:node.rChild];
        }
    }
}

- (NSArray *)nodesKDistanceFromRoot:(NSUInteger)k {
    if (!self.root) {
        return @[]; // Base case
    }
    return [self _nodesKDistanceFromRoot:k onNode:self.root];
}

- (NSArray *)_nodesKDistanceFromRoot:(NSUInteger)k onNode:(BinaryTreeNode *)node {
    if (k == 0) {
        return @[node.obj];
    }
    NSMutableArray *results = [NSMutableArray array];
    if (node.lChild) {
        [results addObjectsFromArray:[self _nodesKDistanceFromRoot:k - 1 onNode:node.lChild]];
    }
    if (node.rChild) {
        [results addObjectsFromArray:[self _nodesKDistanceFromRoot:k - 1 onNode:node.rChild]];
    }
    return results;
}

- (NSUInteger)diameter {
    if (!self.root) {
        return 0;
    }
    return [self _diameterOnNode:self.root];
}

- (NSUInteger)_heightOnNode:(BinaryTreeNode *)node {
    NSUInteger leftHeight = 0;
    if (node.lChild) {
        leftHeight = [self _heightOnNode:node.lChild];
    }
    NSUInteger rightHeight = 0;
    if (node.rChild) {
        rightHeight = [self _heightOnNode:node.rChild];
    }
    return 1 + MAX(leftHeight, rightHeight);
}

- (NSUInteger)_diameterOnNode:(BinaryTreeNode *)node {
    // Going through this node is just the height of left subtree plus the height of right subtree plus 1
    NSUInteger throughNode = [self _heightOnNode:node.lChild] + [self _heightOnNode:node.rChild] + 1;
    NSUInteger leftTree = 0;
    if (node.lChild) {
        leftTree = [self _diameterOnNode:node.lChild];
    }
    NSUInteger rightTree = 0;
    if (node.rChild) {
        rightTree= [self _diameterOnNode:node.rChild];
    }
    return MAX(MAX(leftTree, rightTree), throughNode);
}

- (BOOL)containsTree:(BinaryTree *)tree {
    if (!tree.root) {
        return NO;
    }
    return [self _containsTree:tree onNode:self.root];
}

- (BOOL)_containsTree:(BinaryTree *)tree onNode:(BinaryTreeNode *)node {
    if (!node) {
        return NO;
    }
    if ([self _node:tree.root isEqualToNode:node]) {
        return YES;
    } else {
        if ([tree.root.obj compare:node.obj] == NSOrderedDescending) {
            // Tree.root.obj > node.obj, move right
            return [self _containsTree:tree onNode:node.rChild];
        } else {
            // Tree.root.obj < node.obj, move left
            return [self _containsTree:tree onNode:node.lChild];
        }
    }
}

- (BinaryTree *)mirrorImage {
    BinaryTree *mirrorTree = [[BinaryTree alloc] init];
    if (!self.root) {
        return mirrorTree;
    }
    // Copy over the root
    BinaryTreeNode *mirrorRoot = [BinaryTreeNode nodeWithObj:self.root.obj];
    mirrorTree.root = mirrorRoot;
    // Recursively copy the tree
    [self _mirrorCopyNode:self.root ontoMirrorNode:mirrorTree.root];
    return mirrorTree;
}

- (void)_mirrorCopyNode:(BinaryTreeNode *)node ontoMirrorNode:(BinaryTreeNode *)mirrorNode {
    if (node.lChild) {
        mirrorNode.rChild = [BinaryTreeNode nodeWithObj:node.lChild.obj];
        [self _mirrorCopyNode:node.lChild ontoMirrorNode:mirrorNode.rChild];
    }
    if (node.rChild) {
        mirrorNode.lChild = [BinaryTreeNode nodeWithObj:node.rChild.obj];
        [self _mirrorCopyNode:node.rChild ontoMirrorNode:mirrorNode.lChild];
    }
}

- (void)mirrorTree {
    if (!self.root) {
        return;
    }
    [self swapChildrenRecursivelyOnNode:self.root];
}

- (void)swapChildrenRecursivelyOnNode:(BinaryTreeNode *)node {
    BinaryTreeNode *temp = node.lChild;
    node.lChild = node.rChild;
    node.rChild = temp;
    if (node.lChild) {
        [self swapChildrenRecursivelyOnNode:node.lChild];
    }
    if (node.rChild) {
        [self swapChildrenRecursivelyOnNode:node.rChild];
    }
}

- (void)setAuxPointersToPointToNextRightNode {
    if (!self.root) return; // Base case
    NSMutableArray *queue = [NSMutableArray array];
    BinaryTreeNode *current, *prev;
    [queue addObject:self.root];
    while (queue.count > 0) {
        NSMutableArray *nextLevelQueue = [NSMutableArray array];
        while (queue.count > 0) {
            current = [queue firstObject];
            [queue removeObject:current];
            if (prev) {
                prev.aux = current;
            }
            if (current.lChild) {
                [nextLevelQueue addObject:current.lChild];
            }
            if (current.rChild) {
                [nextLevelQueue addObject:current.rChild];
            }
            prev = current;
        }
        prev = nil;
        queue = nextLevelQueue;
    }
}

- (NSArray *)allRootToLeafPaths {
    if (!self.root) {
        return @[];
    }
    return [self _allRootToLeafPathsOnNode:self.root withCurrentPath:[NSMutableArray array]];
}

- (NSArray *)_allRootToLeafPathsOnNode:(BinaryTreeNode *)node withCurrentPath:(NSMutableArray *)currentPath {
    [currentPath addObject:node.obj];
    if (!node.lChild && !node.rChild) {
        // We are a leaf! Return!
        return @[currentPath];
    }
    NSMutableArray *result = [NSMutableArray array];
    if (node.lChild) {
        [result addObjectsFromArray:[self _allRootToLeafPathsOnNode:node.lChild withCurrentPath:[currentPath mutableCopy]]];
    }
    if (node.rChild) {
        [result addObjectsFromArray:[self _allRootToLeafPathsOnNode:node.rChild withCurrentPath:[currentPath mutableCopy]]];
    }
    return result;
}

@end
