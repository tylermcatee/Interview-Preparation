//
//  BinaryTreeNode.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property (nonatomic, strong) NSObject *obj;
@property (nonatomic, strong) BinaryTreeNode *lChild;
@property (nonatomic, strong) BinaryTreeNode *rChild;

// For any problems that require setting more pointers
@property (nonatomic, strong) BinaryTreeNode *aux;

+ (instancetype)nodeWithObj:(NSObject *)obj;

@end
