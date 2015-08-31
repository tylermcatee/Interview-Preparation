//
//  BinaryTree.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BinaryTreeNode.h"

@interface BinaryTree : NSObject

/**
 *  @method insert:
 *  @discussion Inserts an object into the tree. If the object is already contained in the tree,
 *  nothing happens.
 */
- (void)insert:(NSObject *)obj;

/**
 *  @method contains:
 *  @discussion Returns whether or not the tree contains object obj.
 */
- (BOOL)contains:(NSObject *)obj;

/**
 *  @method remove:
 *  @discussion Deletes obj from tree.
 *  @returns YES if successful, NO if not
 *  @warning Will throw exception if obj is not in tree.
 */
- (BOOL)remove:(NSObject *)obj;

@end
