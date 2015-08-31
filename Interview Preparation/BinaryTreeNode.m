//
//  BinaryTreeNode.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

+ (instancetype)nodeWithObj:(id)obj {
    BinaryTreeNode *treeNode = [[BinaryTreeNode alloc] init];
    treeNode.obj = obj;
    return treeNode;
}

@end
