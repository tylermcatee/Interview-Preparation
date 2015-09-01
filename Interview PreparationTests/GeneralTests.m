//
//  GeneralTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "General.h"

@interface GeneralTests : XCTestCase

@end

@implementation GeneralTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRepeatedNumber {
    NSArray *array = @[@1, @2, @3, @4, @1, @5, @6, @7];
    XCTAssertEqualObjects(@1, [General firstRepeatedNumberInArray:array]);
}

- (void)testRepeatedNumberNoRepeats {
    NSArray *array = @[@1, @2, @3, @4, @5, @6, @7];
    XCTAssertNil([General firstRepeatedNumberInArray:array]);
}

@end
