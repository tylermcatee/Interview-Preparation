///Users/mcatee/code/Interview Preparation/Interview Preparation/Arrays.m
//  ArraysTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Arrays.h"

@interface ArraysTests : XCTestCase

@end

@implementation ArraysTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSwingleSwapSort {
    NSArray *singleSwapped = @[@1, @2, @6, @4, @5, @3, @7, @8];
    NSArray *expected = @[@1, @2, @3, @4, @5, @6, @7, @8,];
    NSArray *result = [Arrays singleSwapSort:singleSwapped];
    XCTAssertEqualObjects(expected, result);
    singleSwapped = @[@4, @3, @5];
    expected = @[@3, @4, @5];
    result = [Arrays singleSwapSort:singleSwapped];
    XCTAssertEqualObjects(expected, result);
    singleSwapped = @[@3, @5 ,@4];
    result = [Arrays singleSwapSort:singleSwapped];
    XCTAssertEqualObjects(expected, result);
}

- (void)testPairsOfNumbers {
    NSArray *testArray = @[@7, @6, @23, @19, @10, @11, @9, @3, @15];
    XCTAssertEqual(6, [Arrays pairsOfNumbersInArray:testArray withDifference:4]);
}

- (void)testBinarySearch {
    NSArray *testArray = @[@1, @3, @4, @7, @10, @12, @24];
    XCTAssertTrue([Arrays array:testArray contains:@1]);
    XCTAssertTrue([Arrays array:testArray contains:@3]);
    XCTAssertTrue([Arrays array:testArray contains:@4]);
    XCTAssertTrue([Arrays array:testArray contains:@7]);
    XCTAssertTrue([Arrays array:testArray contains:@10]);
    XCTAssertTrue([Arrays array:testArray contains:@12]);
    XCTAssertTrue([Arrays array:testArray contains:@24]);
    
    XCTAssertFalse([Arrays array:testArray contains:@-1]);
    XCTAssertFalse([Arrays array:testArray contains:@2]);
    XCTAssertFalse([Arrays array:testArray contains:@5]);
    XCTAssertFalse([Arrays array:testArray contains:@25]);
}

- (void)testMergeSort {
    NSArray *testArray = @[@8, @7, @10, @100, @13, @4, @2, @1, @3, @70, @24, @55, @23];
    NSArray *mergeSorted = [Arrays mergeSortArray:testArray];
    NSArray *systemSorted = [testArray sortedArrayUsingSelector:@selector(compare:)];
    XCTAssertEqualObjects(mergeSorted, systemSorted);
}

- (void)testMinimumDistance {
    NSArray *testOne = @[@4, @1, @8, @2, @16, @32];
    NSArray *testTwo = @[@27, @3, @9, @91, @1];
    NSArray *testThree = @[@128, @16, @1, @4, @1000];
    XCTAssertEqual(1, [Arrays minimumDistanceBetweenElementsOfArray:testOne]);
    XCTAssertEqual(2, [Arrays minimumDistanceBetweenElementsOfArray:testTwo]);
    XCTAssertEqual(3, [Arrays minimumDistanceBetweenElementsOfArray:testThree]);
}

- (void)testMinimumDistanceBetweenNumbers {
    NSArray *testArray = @[@1, @5, @3, @7, @2, @8, @3, @4, @5, @9, @9, @3, @1, @3, @2, @9];
    XCTAssertEqual(4, [Arrays minimumDistanceInArray:testArray between:@4 and:@7]);
    XCTAssertEqual(1, [Arrays minimumDistanceInArray:testArray between:@9 and:@3]);
    XCTAssertEqual(NSNotFound, [Arrays minimumDistanceInArray:testArray between:@4 and:@101]);
    XCTAssertEqual(NSNotFound, [Arrays minimumDistanceInArray:testArray between:@100 and:@1]);
    XCTAssertEqual(NSNotFound, [Arrays minimumDistanceInArray:testArray between:@100 and:@101]);
}

@end
