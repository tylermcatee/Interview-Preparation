//
//  ConcurrencyTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/31/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Concurrency.h"

@interface ConcurrencyTests : XCTestCase

@end

@implementation ConcurrencyTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testConcurrentForLoop {
    // This is an example of a functional test case.
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@1, @1, @1, @1, @1, @1, nil];
    [Concurrency incrementEachItemInArrayByOne:array];
    NSArray *expectedResult = @[@2, @2, @2, @2, @2, @2];
    XCTAssertEqualObjects(expectedResult, [array copy]);
}

@end
