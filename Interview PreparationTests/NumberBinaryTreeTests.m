//
//  NumberBinaryTreeTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/31/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NumberBinaryTree.h"


@interface NumberBinaryTreeTests : XCTestCase

@property (nonatomic, strong) NumberBinaryTree *tree;

@end

@implementation NumberBinaryTreeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tree = [[NumberBinaryTree alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPathsSum {
    // This is an example of a functional test case.
    [self.tree insert:@10];
    [self.tree insert:@5];
    [self.tree insert:@12];
    [self.tree insert:@4];
    [self.tree insert:@7];
    NSArray *result = [self.tree pathsThatSumTo:22];
    NSArray *expectedResult = @[@[@10, @5, @7], @[@10, @12]];
    XCTAssertEqualObjects(expectedResult, result);
    XCTAssertEqualObjects(@[], [self.tree pathsThatSumTo:3]);
}

@end
