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

// Only revealed for testing purposes
@property (nonatomic, strong) BinaryTreeNode *root;

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

/**
 *  @method inOrderRecursive
 *  @dicussion recursive implementation of in order traversal
 */
- (NSArray *)inOrderRecursive;

/**
 *  @method preOrderRecursive
 *  @discussion recursive implementation of pre order traversal
 */
- (NSArray *)preOrderRecursive;

/**
 *  @method postOrderRecursive
 *  @discussion recursive implementation of post order traversal
 */
- (NSArray *)postOrderRecursive;

/**
 *  @method inOrder
 *  @dicussion non-recursive implementation of in order traversal
 */
- (NSArray *)inOrder;

/**
 *  @method preOrder
 *  @discussion non-recursive implementation of pre order traversal
 */
- (NSArray *)preOrder;

/**
 *  @method post
 *  @discussion non-recursive implementation of post order traversal
 */
- (NSArray *)postOrder;

/**
 *  @method isEqual:
 *  @discussion Returns whether two trees have equal contents or not.
 */
- (BOOL)isEqual:(BinaryTree *)tree;

/**
 *  @method isBinarySearchTree
 *  @discussion Returns YES if we are a valid binary search tree and NO if not.
 */
- (BOOL)isBinarySearchTree;

/**
 *  @method nextHighestNodeThan:
 *  @discussion Given a binary tree node find the next highest node.
 */
- (BinaryTreeNode *)nextHighestNodeThan:(BinaryTreeNode *)node;


/**
 *  @method smallest
 *  @discussion returns the smallest node.
 */
- (BinaryTreeNode *)smallest;

/**
 *  @method largest
 *  @discussion returns the largest node.
 */
- (BinaryTreeNode *)largest;

/**
 *  @method lowestCommonAncestorToNode:AndOtherNode:
 *  @param node A node in the tree
 *  @param otherNode another node in the tree
 *  @discussion Returns the lowest common ancestor to the two nodes.
 */
- (BinaryTreeNode *)lowestCommonAncestorToNode:(BinaryTreeNode *)node andOtherNode:(BinaryTreeNode *)otherNode;

/**
 *  @method node:isCousinOfNode:
 *  @discussion http://www.crazyforcode.com/cousin-nodes-binary-tree/
 */
- (BOOL)node:(BinaryTreeNode *)node isCousinOfNode:(BinaryTreeNode *)otherNode;

/**
 *  @method spiralTraversal
 *  @param leftFirst whether to go left first from the root, or right first.
 *  @discussion Prints a spiral traversal of the tree. Goes left to right across the 
 *  levels, alternating, starting at the root and going down.
 */
- (NSArray *)spiralTraversal:(BOOL)leftFirst;

/**
 *  @method spiralTraversalRecursive
 *  @param leftFirst whether to go left first from the root, or right first.
 *  @discussion Prints a spiral traversal of the tree. Goes left to right across the
 *  levels, alternating, starting at the root and going down.
 */
- (NSArray *)spiralTraversalRecursive:(BOOL)leftFirst;

/**
 *  @method levelTraversal
 *  @discussion Does a non-recursive level traversal of the tree
 */
- (NSArray *)levelTraversal;

/**
 *  @method levelTraversalRecursive
 *  @discussion Does a recursive level traversal of the tree.
 */
- (NSArray *)levelTraversalRecursive;

/**
 *  @method elementsGreaterThan:andSmallerThan:
 *  @discussion Returns the elements between minimum and larger than maximum, in order.
 */
- (NSArray *)elementsGreaterThan:(NSObject *)minimum andSmallerThan:(NSObject *)maximum;

/**
 *  @method deleteLeaves
 *  @discussion Deletes all leaves from the tree.
 */
- (void)deleteLeaves;

/**
 *  @method nodesKDistanceFromRoot
 *  @discussion Return nodes at K distance from root.
 */
- (NSArray *)nodesKDistanceFromRoot:(NSUInteger)k;

/**
 *  @method diameter
 *  @discussion Returns the diameter of the tree.
 *  http://www.crazyforcode.com/diameter-tree/
 */
- (NSUInteger)diameter;

/**
 *  @method containsTree:
 *  @param tree Another BinaryTree that may be a subtree of this tree.
 *  @discussion Check if tree is a subtree of this BinaryTree.
 */
- (BOOL)containsTree:(BinaryTree *)tree;

@end
