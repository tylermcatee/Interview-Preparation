//
//  NSMutableArray+Stack.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Stack)

- (void)push:(id)obj;
- (id)pop;
- (BOOL)isEmpty;

@end
