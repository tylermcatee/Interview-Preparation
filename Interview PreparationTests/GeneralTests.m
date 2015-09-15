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

- (void)testSortedArrayContains {
    NSArray *sortedArray = @[@1, @3, @5, @7, @9, @11, @13];
    XCTAssertFalse([General sortedArray:sortedArray contains:@0]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@1]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@2]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@3]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@4]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@5]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@6]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@7]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@8]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@9]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@10]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@11]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@12]);
    XCTAssertTrue([General sortedArray:sortedArray contains:@13]);
    XCTAssertFalse([General sortedArray:sortedArray contains:@14]);
}

- (void)testTimeFormat {
    NSUInteger seconds = 10;
    NSString *ten = [General timeStringForSecondsPastMidnight:seconds];
    XCTAssertEqualObjects(@"12:00:10AM", ten);
    seconds = 3601;
    NSString *hour_and_second = [General timeStringForSecondsPastMidnight:seconds];
    XCTAssertEqualObjects(@"01:00:01AM", hour_and_second);
    seconds = 12 * 3600;
    NSString *twelve_hours = [General timeStringForSecondsPastMidnight:seconds];
    XCTAssertEqualObjects(@"12:00:00PM", twelve_hours);
    seconds = 13 * 3600 + 20 * 60 + 16;
    NSString *thirteen_hours_twenty_minutes_sixteen_seconds = [General timeStringForSecondsPastMidnight:seconds];
    XCTAssertEqualObjects(@"01:20:16PM", thirteen_hours_twenty_minutes_sixteen_seconds);
}

- (void)testNumberElements {
    NSArray *exampleArray = @[@7, @6, @23, @19, @10, @11, @9, @3, @15];
    XCTAssertEqual(6, [General numberOfElementsIn:exampleArray withDifference:4]);
}

@end
