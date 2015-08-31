//
//  BinaryTreeTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 8/30/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryTree.h"
#import "BinaryTreeNode.h"

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

- (void)testIsEqualYes {
    [self.tree insert:@"B"];
    [self.tree insert:@"A"];
    [self.tree insert:@"C"];
    
    BinaryTree *otherTree = [[BinaryTree alloc] init];
    [otherTree insert:@"B"];
    [otherTree insert:@"A"];
    [otherTree insert:@"C"];
    
    XCTAssertTrue([self.tree isEqual:otherTree]);
}

- (void)testIsEqualNo {
    [self.tree insert:@"A"];
    [self.tree insert:@"B"];
    [self.tree insert:@"C"];
    
    BinaryTree *otherTree = [[BinaryTree alloc] init];
    [otherTree insert:@"B"];
    [otherTree insert:@"A"];
    [otherTree insert:@"C"];
    
    XCTAssertFalse([self.tree isEqual:otherTree]);
}

- (BinaryTreeNode *)invalidBinaryTreeRoot {
    BinaryTreeNode *three = [BinaryTreeNode nodeWithObj:@3];
    BinaryTreeNode *two = [BinaryTreeNode nodeWithObj:@2];
    BinaryTreeNode *five = [BinaryTreeNode nodeWithObj:@5];
    three.lChild = two;
    three.rChild = five;
    BinaryTreeNode *one = [BinaryTreeNode nodeWithObj:@1];
    BinaryTreeNode *four = [BinaryTreeNode nodeWithObj:@4];
    two.lChild = one;
    two.rChild = four;
    return three;
}

- (void)testIsBinarySearchTree {
    BinaryTree *invalid = [[BinaryTree alloc] init];
    invalid.root = [self invalidBinaryTreeRoot];
    XCTAssertFalse([invalid isBinarySearchTree]);
}

- (void)testValidBinarySearchTree {
    [self populateExampleTree];
    XCTAssertTrue([self.tree isBinarySearchTree]);
}

- (void)testNextHighestWithoutRChild {
    [self populateExampleTree];
    // Get the '9'
    BinaryTreeNode *nineNode = self.tree.root.lChild.rChild.rChild;
    // Get the '10'
    BinaryTreeNode *tenNode = self.tree.root;
    // Check next highest
    XCTAssertEqual(tenNode, [self.tree nextHighestNodeThan:nineNode]);
}

- (void)testNextHighestWithRChild {
    [self populateExampleTree];
    // Get the '7'
    BinaryTreeNode *sevenNode = self.tree.root.lChild.rChild;
    // Get the '9'
    BinaryTreeNode *nineNode = self.tree.root.lChild.rChild.rChild;
    // Check the next highest
    XCTAssertEqual(nineNode, [self.tree nextHighestNodeThan:sevenNode]);
}

- (void)testNextHighestNotInTree {
    [self populateExampleTree];
    BinaryTreeNode *newNode = [BinaryTreeNode nodeWithObj:@1];
    XCTAssertNil([self.tree nextHighestNodeThan:newNode]);
}

- (void)testNoNextHighest {
    [self populateExampleTree];
    // Get the '25' Node
    BinaryTreeNode *twentyFiveNode = self.tree.root.rChild.rChild.rChild;
    XCTAssertNil([self.tree nextHighestNodeThan:twentyFiveNode]);
}

- (void)testLowestCommonAncestor {
    [self populateExampleTree];
    // Get the '6'
    BinaryTreeNode *sixNode = self.tree.root.lChild.rChild.lChild;
    // Get the '7'
    BinaryTreeNode *sevenNode = self.tree.root.lChild.rChild;
    // Get the '9'
    BinaryTreeNode *nineNode = self.tree.root.lChild.rChild.rChild;
    // Get the '10'
    BinaryTreeNode *tenNode = self.tree.root;
    // Get the '12'
    BinaryTreeNode *twelveNode = self.tree.root.rChild.lChild;
    // Get the '15'
    BinaryTreeNode *fifteenNode = self.tree.root.rChild;
    // Get the '25' Node
    BinaryTreeNode *twentyFiveNode = self.tree.root.rChild.rChild.rChild;

    XCTAssertEqual(sevenNode, [self.tree lowestCommonAncestorToNode:sixNode andOtherNode:nineNode]);
    XCTAssertEqual(tenNode, [self.tree lowestCommonAncestorToNode:tenNode andOtherNode:twentyFiveNode]);
    XCTAssertEqual(tenNode, [self.tree lowestCommonAncestorToNode:nineNode andOtherNode:twentyFiveNode]);
    XCTAssertEqual(fifteenNode, [self.tree lowestCommonAncestorToNode:twelveNode andOtherNode:twentyFiveNode]);
}

- (void)testCousinsSuccess {
    [self populateExampleTree];
    
    // Get the '9'
    BinaryTreeNode *nineNode = self.tree.root.lChild.rChild.rChild;
    // Get the '18'
    BinaryTreeNode *eighteenNode = self.tree.root.rChild.rChild.lChild;
    
    XCTAssertTrue([self.tree node:nineNode isCousinOfNode:eighteenNode]);
}

- (void)testCousinsFail {
    [self populateExampleTree];
    
    // Get the '9'
    BinaryTreeNode *nineNode = self.tree.root.lChild.rChild.rChild;
    // Get the '12'
    BinaryTreeNode *twelveNode = self.tree.root.rChild.lChild;
    
    XCTAssertFalse([self.tree node:nineNode isCousinOfNode:twelveNode]);
}

- (void)testSpiralTraversalLeft {
    [self populateExampleTree];
    NSArray *correctTraversal = @[@10, @5, @15, @20, @12, @7, @4, @6, @9, @18, @25];
    XCTAssertEqualObjects(correctTraversal, [self.tree spiralTraversal:YES]);
}

- (void)testSpiralTraversalRight {
    [self populateExampleTree];
    NSArray *correctTraversal = @[@10, @15, @5, @4, @7, @12, @20, @25, @18, @9, @6];
    XCTAssertEqualObjects(correctTraversal, [self.tree spiralTraversal:NO]);
}

@end
