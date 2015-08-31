//
//  NumberBinaryTree.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/31/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "NumberBinaryTree.h"

@implementation NumberBinaryTree

- (void)insert:(NSNumber *)obj {
    assert([obj isKindOfClass:[NSNumber class]]);
    [super insert:obj];
}

- (BOOL)contains:(NSNumber *)obj {
    assert([obj isKindOfClass:[NSNumber class]]);
    return [super contains:obj];
}

- (BOOL)remove:(NSNumber *)obj {
    assert([obj isKindOfClass:[NSNumber class]]);
    return [super remove:obj];
}

- (NSArray *)pathsThatSumTo:(NSInteger)targetSum {
    if (!self.root) {
        return @[]; // No paths
    }
    return [self _pathsThatSumTo:targetSum onNode:self.root withCurrentSum:0 andCurrentPath:[NSMutableArray array]];
}

- (NSArray *)_pathsThatSumTo:(NSInteger)targetSum onNode:(BinaryTreeNode *)node withCurrentSum:(NSUInteger)currentSum andCurrentPath:(NSMutableArray *)currentPath {
    currentSum += [((NSNumber *)node.obj) intValue];
    [currentPath addObject:node.obj];
    NSMutableArray *results = [NSMutableArray array];
    if (currentSum == targetSum) {
        // This path sums correctly!
        [results addObject:currentPath];
    }
    if (node.lChild) {
        [results addObjectsFromArray:[self _pathsThatSumTo:targetSum onNode:node.lChild withCurrentSum:currentSum andCurrentPath:[currentPath mutableCopy]]];
    }
    if (node.rChild) {
        [results addObjectsFromArray:[self _pathsThatSumTo:targetSum onNode:node.rChild withCurrentSum:currentSum andCurrentPath:[currentPath mutableCopy]]];
    }
    return results;
}

@end
