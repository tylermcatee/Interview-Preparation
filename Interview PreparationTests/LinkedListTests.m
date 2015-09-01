//
//  LinkedListTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/1/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListNode.h"
#import "ListUtils.h"

@interface LinkedListTests : XCTestCase

@property (nonatomic, strong) ListNode *list;

@end

@implementation LinkedListTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPushFront {
    self.list = [ListNode nodeWithObject:@1];
    NSArray *expected = @[@1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list pushFront:@2];
    expected = @[@2, @1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list pushFront:@3];
    expected = @[@3, @2, @1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testPushBack {
    self.list = [ListNode nodeWithObject:@1];
    NSArray *expected = @[@1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list pushBack:@2];
    expected = @[@1, @2];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list pushBack:@3];
    expected = @[@1, @2, @3];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testInsertAfterNode {
    self.list = [ListNode nodeWithObject:@1];
    NSArray *expected = @[@1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list insert:@2 afterNode:nil];
    expected = @[@2, @1];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list insert:@3 afterNode:self.list.next];
    expected = @[@2, @1, @3];
    XCTAssertEqualObjects(expected, [self.list asArray]);
    [self.list insert:@4 afterNode:self.list.next];
    expected = @[@2, @1, @4, @3];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testInsertAfterNodeNotInList {
    ListNode *fakeNode = [[ListNode alloc] init];
    fakeNode.obj = @1;
    self.list = [ListNode nodeWithObject:@1];
    [self.list pushFront:@2];
    [self.list pushFront:@3];
    XCTAssertNil([self.list insert:@4 afterNode:fakeNode]);
}

- (void)testFromArray {
    NSArray *arr = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    ListNode *list = [ListNode listFromArray:arr];
    XCTAssertEqualObjects(arr, [list asArray]);
}

- (void)testContains {
    XCTAssertFalse([ListUtils list:self.list contains:nil]);
    XCTAssertFalse([ListUtils list:self.list contains:@1]);
    NSArray *contains = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSArray *doesntContain = @[@11, @12, @13, @0, @-1];
    self.list = [ListNode listFromArray:contains];
    for (NSObject *object in contains) {
        XCTAssertTrue([ListUtils list:self.list contains:object]);
    }
    for (NSObject *object in doesntContain) {
        XCTAssertFalse([ListUtils list:self.list contains:object]);
    }
}

- (void)testListLength {
    XCTAssertEqual(0, [ListUtils listLength:self.list]);
    self.list = [ListNode listFromArray:@[@1]];
    XCTAssertEqual(1, [ListUtils listLength:self.list]);
    [self.list pushFront:@1];
    XCTAssertEqual(2, [ListUtils listLength:self.list]);
    [self.list pushFront:@1];
    XCTAssertEqual(3, [ListUtils listLength:self.list]);
    [self.list pushFront:@1];
    XCTAssertEqual(4, [ListUtils listLength:self.list]);
}

- (void)testMthToLast {
    self.list = [ListNode listFromArray:@[@1, @2, @3, @4, @5, @6, @7, @8]];
    XCTAssertNil([ListUtils mthToLast:8 onList:self.list]);
    XCTAssertEqualObjects(@1, [ListUtils mthToLast:7 onList:self.list]);
    XCTAssertEqualObjects(@2, [ListUtils mthToLast:6 onList:self.list]);
    XCTAssertEqualObjects(@3, [ListUtils mthToLast:5 onList:self.list]);
    XCTAssertEqualObjects(@4, [ListUtils mthToLast:4 onList:self.list]);
    XCTAssertEqualObjects(@5, [ListUtils mthToLast:3 onList:self.list]);
    XCTAssertEqualObjects(@6, [ListUtils mthToLast:2 onList:self.list]);
    XCTAssertEqualObjects(@7, [ListUtils mthToLast:1 onList:self.list]);
    XCTAssertEqualObjects(@8, [ListUtils mthToLast:0 onList:self.list]);
    XCTAssertNil([ListUtils mthToLast:-1 onList:self.list]);
}

- (void)testSortListOf0s1sAnd2s {
    NSArray *unsorted = @[@0, @2, @1, @2, @0, @0, @1, @1, @2, @0, @0, @1, @2, @0];
    NSArray *sorted = [[unsorted copy] sortedArrayUsingSelector:@selector(compare:)];
    self.list = [ListNode listFromArray:unsorted];
    [ListUtils sortListOfOnly0s1sAnd2s:self.list];
    XCTAssertEqualObjects(sorted, [self.list asArray]);
}

- (void)testRepeatedlyDeleteRegular {
    NSArray *start = @[@1, @2, @3, @4, @5, @6, @7, @8];
    NSArray *expected = @[@1, @2, @5, @6];
    self.list = [ListNode listFromArray:start];
    [ListUtils repeatedlyDeleteN:2 afterM:2 onList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

@end
