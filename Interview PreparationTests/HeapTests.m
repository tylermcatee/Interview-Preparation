//
//  HeapTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/3/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Heap.h"

@interface HeapTests : XCTestCase

@property (nonatomic, strong) Heap *heap;

@end

@implementation HeapTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMakeMinHeap {
    self.heap = [Heap minHeap];
}

- (void)testMakeMaxHeap {
    self.heap = [Heap maxHeap];
}

- (void)testInsertionOnMin {
    self.heap = [Heap minHeap];
    XCTAssertNil([self.heap headElement]);
    [self.heap pushHeap:@1];
    XCTAssertEqualObjects(@1, [self.heap headElement]);
    [self.heap pushHeap:@2];
    XCTAssertEqualObjects(@1, [self.heap headElement]);
    [self.heap pushHeap:@3];
    XCTAssertEqualObjects(@1, [self.heap headElement]);
    [self.heap pushHeap:@0];
    XCTAssertEqualObjects(@0, [self.heap headElement]);
}

- (void)testInsertionOnMax {
    self.heap = [Heap maxHeap];
    XCTAssertNil([self.heap headElement]);
    [self.heap pushHeap:@10];
    XCTAssertEqualObjects(@10, [self.heap headElement]);
    [self.heap pushHeap:@2];
    XCTAssertEqualObjects(@10, [self.heap headElement]);
    [self.heap pushHeap:@3];
    XCTAssertEqualObjects(@10, [self.heap headElement]);
    [self.heap pushHeap:@20];
    XCTAssertEqualObjects(@20, [self.heap headElement]);
}

- (void)testPopHeapOnMin {
    self.heap = [Heap minHeap];
    [self.heap pushHeap:@10];
    [self.heap pushHeap:@5];
    [self.heap pushHeap:@7];
    [self.heap pushHeap:@3];
    [self.heap pushHeap:@4];
    [self.heap pushHeap:@1];
    [self.heap pushHeap:@2];
    [self.heap pushHeap:@6];
    XCTAssertEqualObjects(@1, [self.heap popHeap]);
    XCTAssertEqualObjects(@2, [self.heap popHeap]);
    XCTAssertEqualObjects(@3, [self.heap popHeap]);
    XCTAssertEqualObjects(@4, [self.heap popHeap]);
    XCTAssertEqualObjects(@5, [self.heap popHeap]);
    XCTAssertEqualObjects(@6, [self.heap popHeap]);
    XCTAssertEqualObjects(@7, [self.heap popHeap]);
    XCTAssertEqualObjects(@10, [self.heap popHeap]);
    XCTAssertNil([self.heap popHeap]);
}

- (void)testPopHeadOnMax {
    self.heap = [Heap maxHeap];
    [self.heap pushHeap:@10];
    [self.heap pushHeap:@5];
    [self.heap pushHeap:@7];
    [self.heap pushHeap:@3];
    [self.heap pushHeap:@4];
    [self.heap pushHeap:@1];
    [self.heap pushHeap:@2];
    [self.heap pushHeap:@6];
    XCTAssertEqualObjects(@10, [self.heap popHeap]);
    XCTAssertEqualObjects(@7, [self.heap popHeap]);
    XCTAssertEqualObjects(@6, [self.heap popHeap]);
    XCTAssertEqualObjects(@5, [self.heap popHeap]);
    XCTAssertEqualObjects(@4, [self.heap popHeap]);
    XCTAssertEqualObjects(@3, [self.heap popHeap]);
    XCTAssertEqualObjects(@2, [self.heap popHeap]);
    XCTAssertEqualObjects(@1, [self.heap popHeap]);
    XCTAssertNil([self.heap popHeap]);
}

- (void)testSortedArrayMinToMax {
    NSArray *numArray = @[@0, @17, @8, @129, @25, @18, @-17, @-572, @1, @3, @4, @87, @172];
    NSArray *systemSorted = [numArray sortedArrayUsingSelector:@selector(compare:)];
    NSArray *heapSorted = [Heap sortedArray:numArray usingSmallestToLargest:YES];
    XCTAssertEqualObjects(systemSorted, heapSorted);
}

- (void)testSortedArrayMaxToMin {
    NSArray *numArray = @[@0, @17, @8, @129, @25, @18, @-17, @-572, @1, @3, @4, @87, @172];
    NSArray *systemSorted = [numArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj2 compare:obj1];
    }];
    NSArray *heapSorted = [Heap sortedArray:numArray usingSmallestToLargest:NO];
    XCTAssertEqualObjects(systemSorted, heapSorted);
}

@end
