//
//  BinaryTreeTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryTree.h"

@interface BinaryTreeTests : XCTestCase

@property (nonatomic, strong) BinaryTree *tree;

@end


@implementation BinaryTreeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.tree = [[BinaryTree alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Basic Functionality Recursively

- (void)testInsert {
    // Insert A
    [self.tree insert:@"A"];
}

- (void)testContains {
    XCTAssertFalse([self.tree contains:@"A"]);
    [self.tree insert:@"A"];
    XCTAssertTrue([self.tree contains:@"A"]);
}

- (void)testManyContainsIndividually {
    NSArray *insertionItems = @[@"A", @"S", @"D", @"F", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U"];
    for (NSObject *insertionItem in insertionItems) {
        XCTAssertFalse([self.tree contains:insertionItem]);
        [self.tree insert:insertionItem];
        XCTAssertTrue([self.tree contains:insertionItem]);
    }
}

- (void)testManyContainsAllAtOnce {
    NSArray *insertionItems = @[@"A", @"S", @"D", @"F", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U"];
    for (NSObject *insertionItem in insertionItems) {
        XCTAssertFalse([self.tree contains:insertionItem]);
    }
    for (NSObject *insertionItem in insertionItems) {
        [self.tree insert:insertionItem];
    }
    for (NSObject *insertionItem in insertionItems) {
        XCTAssertTrue([self.tree contains:insertionItem]);
    }
}

- (void)testDoesntContain {
    NSArray *insertionItems = @[@"A", @"S", @"D", @"F", @"Q", @"W", @"E", @"R", @"T", @"Y", @"U"];
    for (NSObject *insertionItem in insertionItems) {
        [self.tree insert:insertionItem];
    }
    XCTAssertFalse([self.tree contains:@"Purple"]);
}

- (void)testRemoveNoRoot {
    XCTAssertFalse([self.tree remove:@"A"]);
}

- (void)testRemoveOnlyRoot {
    [self.tree insert:@"A"];
    XCTAssertTrue([self.tree contains:@"A"]);
    XCTAssertTrue([self.tree remove:@"A"]);
    XCTAssertFalse([self.tree contains:@"A"]);
}

- (void)testRootOnlyLChild {
    [self.tree insert:@"B"];
    [self.tree insert:@"A"];
    XCTAssertTrue([self.tree contains:@"B"]);
    XCTAssertTrue([self.tree contains:@"A"]);
    XCTAssertTrue([self.tree remove:@"B"]);
    XCTAssertFalse([self.tree contains:@"B"]);
    XCTAssertTrue([self.tree contains:@"A"]);
}

- (void)testRootOnlyRChild {
    [self.tree insert:@"B"];
    [self.tree insert:@"C"];
    XCTAssertTrue([self.tree contains:@"B"]);
    XCTAssertTrue([self.tree contains:@"C"]);
    XCTAssertTrue([self.tree remove:@"B"]);
    XCTAssertFalse([self.tree contains:@"B"]);
    XCTAssertTrue([self.tree contains:@"C"]);
}

- (void)testRemoveWithBothChildren {
    [self populateExampleTree];
    XCTAssertTrue([self.tree contains:@5]);
    XCTAssertTrue([self.tree remove:@5]);
    XCTAssertFalse([self.tree contains:@5]);
    XCTAssertTrue([self.tree contains:@4]);
    XCTAssertTrue([self.tree contains:@7]);
}

- (void)testRemoveWithNoChildren {
    [self populateExampleTree];
    XCTAssertTrue([self.tree contains:@4]);
    XCTAssertTrue([self.tree remove:@4]);
    XCTAssertFalse([self.tree contains:@4]);
}

#pragma mark - Example Tree

- (void)populateExampleTree {
    [self.tree insert:@10];
    [self.tree insert:@5];
    [self.tree insert:@15];
    [self.tree insert:@4];
    [self.tree insert:@7];
    [self.tree insert:@12];
    [self.tree insert:@20];
    [self.tree insert:@6];
    [self.tree insert:@9];
    [self.tree insert:@18];
    [self.tree insert:@25];
}

- (NSArray *)exampleInOrder {
    return @[@4, @5, @6, @7, @9, @10, @12, @15, @18, @20, @25];
}

- (NSArray *)examplePreOrder {
    return @[@10, @5, @4, @7, @6, @9, @15, @12, @20, @18, @25];
}

- (NSArray *)examplePostOrder {
    return @[@4, @6, @9, @7, @5, @12, @18, @25, @20, @15, @10];
}

#pragma mark - Traversals

- (void)testInOrderRecursiveEmpty {
    XCTAssertEqualObjects(@[], [self.tree inOrderRecursive]);
}

- (void)testInOrderRecursive {
    [self populateExampleTree];
    NSArray *resultInOrder = [self.tree inOrderRecursive];
    NSArray *exampleInOrder = [self exampleInOrder];
    XCTAssertEqualObjects(resultInOrder, exampleInOrder);
}

- (void)testPreOrderRecursiveEmpty {
    XCTAssertEqualObjects(@[], [self.tree preOrderRecursive]);
}

- (void)testPreOrderRecursive {
    [self populateExampleTree];
    NSArray *resultPreOrder = [self.tree preOrderRecursive];
    NSArray *examplePreOrder = [self examplePreOrder];
    XCTAssertEqualObjects(resultPreOrder, examplePreOrder);
}

- (void)testPostOrderRecursiveEmpty {
    XCTAssertEqualObjects(@[], [self.tree postOrderRecursive]);
}

- (void)testPostOrderRecursive {
    [self populateExampleTree];
    NSArray *resultPostOrder = [self.tree postOrderRecursive];
    NSArray *examplePostOrder = [self examplePostOrder];
    XCTAssertEqualObjects(resultPostOrder, examplePostOrder);
}

- (void)testInOrderEmpty {
    XCTAssertEqualObjects(@[], [self.tree inOrder]);
}

- (void)testInOrder {
    [self populateExampleTree];
    NSArray *resultInOrder = [self.tree inOrder];
    NSArray *exampleInOrder = [self exampleInOrder];
    XCTAssertEqualObjects(resultInOrder, exampleInOrder);
}

- (void)testPreOrderEmpty {
    XCTAssertEqualObjects(@[], [self.tree preOrder]);
}

- (void)testPreOrder {
    [self populateExampleTree];
    NSArray *resultPreOrder = [self.tree preOrder];
    NSArray *examplePreOrder = [self examplePreOrder];
    XCTAssertEqualObjects(resultPreOrder, examplePreOrder);
}

- (void)testPostOrderEmpty {
    XCTAssertEqualObjects(@[], [self.tree postOrder]);
}

- (void)testPostOrder {
    [self populateExampleTree];
    NSArray *resultPostOrder = [self.tree postOrder];
    NSArray *examplePostOrder = [self examplePostOrder];
    XCTAssertEqualObjects(resultPostOrder, examplePostOrder);
}

@end
