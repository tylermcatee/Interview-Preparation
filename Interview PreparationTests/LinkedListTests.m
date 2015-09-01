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
    self.list = [ListUtils repeatedlyDeleteM:2 afterN:2 onList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testRepeatedlyDeleteOnHead {
    NSArray *start = @[@1, @2, @3, @4, @5, @6, @7, @8];
    self.list = [ListNode listFromArray:start];
    self.list = [ListUtils repeatedlyDeleteM:1 afterN:0 onList:self.list];
    XCTAssertNil(self.list);
}

- (void)testRemoveDuplicates {
    NSArray *start = @[@1, @2, @2, @2, @3, @2, @4, @5, @5, @4, @6];
    NSArray *expected = @[@1, @2, @3, @4, @5, @6];
    self.list = [ListNode listFromArray:start];
    [ListUtils removeDuplicatesFromList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testRemoveDuplicatesWithoutDictionary {
    NSArray *start = @[@1, @2, @2, @2, @3, @2, @4, @5, @5, @4, @6];
    NSArray *expected = @[@1, @2, @3, @4, @5, @6];
    self.list = [ListNode listFromArray:start];
    [ListUtils removeDuplicatesFromListWithoutDictionary:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testReverseListEmpty {
    XCTAssertNil([ListUtils reverseList:self.list]);
}

- (void)testReverseList {
    NSArray *start = @[@1, @2, @3, @4];
    NSArray *expected = @[@4, @3, @2, @1];
    self.list = [ListNode listFromArray:start];
    self.list = [ListUtils reverseList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testReverseListSingle {
    NSArray *start = @[@1];
    NSArray *expected = @[@1];
    self.list = [ListNode listFromArray:start];
    self.list = [ListUtils reverseList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testRecursiveReverseListEmpty {
    XCTAssertNil([ListUtils recursiveReverseList:self.list]);
}

- (void)testRecursiveReverseListSingle {
    NSArray *start = @[@1];
    NSArray *expected = @[@1];
    self.list = [ListNode listFromArray:start];
    self.list = [ListUtils recursiveReverseList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testRecursiveReverseList {
    NSArray *start = @[@1, @2, @3, @4];
    NSArray *expected = @[@4, @3, @2, @1];
    self.list = [ListNode listFromArray:start];
    self.list = [ListUtils recursiveReverseList:self.list];
    XCTAssertEqualObjects(expected, [self.list asArray]);
}

- (void)testAsReverseArray {
    NSArray *start = @[@1, @2, @3, @4];
    NSArray *expected = @[@4, @3, @2, @1];
    self.list = [ListNode listFromArray:start];
    XCTAssertEqualObjects(expected, [self.list asReverseArray]);
}

- (void)testReverseEveryK {
    NSArray *testArray = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSArray *reversed1 = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    NSArray *reversed2 = @[@2, @1, @4, @3, @6, @5, @8, @7, @10, @9];
    NSArray *reversed3 = @[@3, @2, @1, @6, @5, @4, @9, @8, @7, @10];
    NSArray *reversed4 = @[@4, @3, @2, @1, @8, @7, @6, @5, @10, @9];
    NSArray *reversed5 = @[@5, @4, @3, @2, @1, @10, @9, @8, @7, @6];
    
    self.list = [ListNode listFromArray:testArray];
    XCTAssertEqualObjects(reversed1, [[ListUtils reverseEveryKNodes:1 onList:self.list] asArray]);
    self.list = [ListNode listFromArray:testArray];
    XCTAssertEqualObjects(reversed2, [[ListUtils reverseEveryKNodes:2 onList:self.list] asArray]);
    self.list = [ListNode listFromArray:testArray];
    XCTAssertEqualObjects(reversed3, [[ListUtils reverseEveryKNodes:3 onList:self.list] asArray]);
    self.list = [ListNode listFromArray:testArray];
    XCTAssertEqualObjects(reversed4, [[ListUtils reverseEveryKNodes:4 onList:self.list] asArray]);
    self.list = [ListNode listFromArray:testArray];
    XCTAssertEqualObjects(reversed5, [[ListUtils reverseEveryKNodes:5 onList:self.list] asArray]);
}

- (void)testListIsCircular {
    NSArray *listItems = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    self.list = [ListNode listFromArray:listItems];
    XCTAssertFalse([ListUtils listIsCircular:self.list]);
    // Make it circular
    self.list.next.next.next.next.next.next.next.next = self.list.next;
    XCTAssertTrue([ListUtils listIsCircular:self.list]);
}

- (void)testRemoveLoopOnList {
    NSArray *listItems = @[@1, @2, @3, @4, @5, @6, @7, @8, @9, @10];
    self.list = [ListNode listFromArray:listItems];
    XCTAssertFalse([ListUtils listIsCircular:self.list]);
    // Make it circular
    self.list.next.next.next.next.next.next.next.next = self.list.next;
    XCTAssertTrue([ListUtils listIsCircular:self.list]);
    // Remove loop
    [ListUtils removeLoopOnList:self.list];
    XCTAssertFalse([ListUtils listIsCircular:self.list]);
}

- (void)testMergeListSameLength {
    NSArray *array1 = @[@1, @2, @3];
    NSArray *array2 = @[@4, @5, @6];
    NSArray *expectedResult = @[@1, @4, @2, @5, @3, @6];
    ListNode *list1 = [ListNode listFromArray:array1];
    ListNode *list2 = [ListNode listFromArray:array2];
    ListNode *result = [ListUtils mergeList:list1 andList:list2];
    XCTAssertEqualObjects(expectedResult, [result asArray]);
}

- (void)testMergeListsLongerFirst {
    NSArray *array1 = @[@1, @2, @3, @7, @8, @9];
    NSArray *array2 = @[@4, @5, @6];
    NSArray *expectedResult = @[@1, @4, @2, @5, @3, @6, @7, @8, @9];
    ListNode *list1 = [ListNode listFromArray:array1];
    ListNode *list2 = [ListNode listFromArray:array2];
    ListNode *result = [ListUtils mergeList:list1 andList:list2];
    XCTAssertEqualObjects(expectedResult, [result asArray]);
}

- (void)testMergeListLongerSecond {
    NSArray *array1 = @[@1, @2, @3];
    NSArray *array2 = @[@4, @5, @6, @7, @8, @9];
    NSArray *expectedResult = @[@1, @4, @2, @5, @3, @6, @7, @8, @9];
    ListNode *list1 = [ListNode listFromArray:array1];
    ListNode *list2 = [ListNode listFromArray:array2];
    ListNode *result = [ListUtils mergeList:list1 andList:list2];
    XCTAssertEqualObjects(expectedResult, [result asArray]);
}

- (void)testMergeListNilFirst {
    NSArray *array2 = @[@4, @5, @6];
    ListNode *list2 = [ListNode listFromArray:array2];
    ListNode *result = [ListUtils mergeList:nil andList:list2];
    XCTAssertEqualObjects(array2, [result asArray]);
}

- (void)testMergeListNilSecond {
    NSArray *array1 = @[@1, @2, @3];
    ListNode *list1 = [ListNode listFromArray:array1];
    ListNode *result = [ListUtils mergeList:list1 andList:nil];
    XCTAssertEqualObjects(array1, [result asArray]);
}

- (void)testCopyListWithAuxPointers {
    NSArray *items = @[@1, @2, @3, @4];
    self.list = [ListNode listFromArray:items];
    // Generate the aux shape
    self.list.aux = self.list.next.next; // 1 -> 3
    self.list.next.aux = self.list.next.next.next; // 2 -> 4
    self.list.next.next.aux = self.list.next; // 3 -> 2
    // Grab the original ListNodes so we can make sure that the operation wasn't destructive
    ListNode *original1 = self.list;
    ListNode *original2 = self.list.next;
    ListNode *original3 = self.list.next.next;
    ListNode *original4 = self.list.next.next.next;
    // Create the copied list
    ListNode *copiedList = [ListUtils copyListWithAuxPointers:self.list];
    // Make sure we didn't destroy the original list now
    XCTAssertEqualObjects(original1, self.list);
    XCTAssertEqualObjects(original2, self.list.next);
    XCTAssertEqualObjects(original3, self.list.next.next);
    XCTAssertEqualObjects(original4, self.list.next.next.next);
    // Now check to see that the copied list is at least the same values
    XCTAssertEqualObjects(items, [copiedList asArray]);
    // Now grab the list nodes to check their aux values
    ListNode *new1 = copiedList;
    ListNode *new2 = copiedList.next;
    ListNode *new3 = copiedList.next.next;
    ListNode *new4 = copiedList.next.next.next;
    // Check the aux values
    XCTAssertEqualObjects(new3, new1.aux);
    XCTAssertEqualObjects(new4, new2.aux);
    XCTAssertEqualObjects(new2, new3.aux);
    XCTAssertNil(new4.aux);
}

@end
