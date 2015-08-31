//
//  NumberBinaryTree.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/31/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "BinaryTree.h"

@interface NumberBinaryTree : BinaryTree

- (void)insert:(NSNumber *)obj;
- (BOOL)contains:(NSNumber *)obj;
- (BOOL)remove:(NSNumber *)obj;


/**
 *  @method pathsThatSumTo:
 *  @discussion All nodes along children pointers from root 
 *  to leaf nodes form a path in a binary tree. Given a binary
 *  tree and a number, please return all paths where the sum
 *  of all nodes value is same as the given number.
 */
- (NSArray *)pathsThatSumTo:(NSInteger)targetSum;

@end
