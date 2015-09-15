//
//  General.h
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface General : NSObject

+ (NSNumber *)firstRepeatedNumberInArray:(NSArray *)array;

+ (BOOL)sortedArray:(NSArray *)array contains:(NSNumber *)number;

+ (NSString *)timeStringForSecondsPastMidnight:(NSUInteger)seconds;

+ (NSUInteger)numberOfElementsIn:(NSArray *)array withDifference:(NSUInteger)difference;

+ (BOOL)rectanglesOverlap:(CGRect)rect1 and:(CGRect)rect2;

@end
