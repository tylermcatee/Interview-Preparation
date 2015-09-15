//
//  CacheTests.m
//  Interview Preparation
//
//  Created by Tyler McAtee on 9/4/15.
//  Copyright (c) 2015 McAtee. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Cache.h"

@interface CacheTests : XCTestCase

@property (nonatomic, strong) Cache *cache;

@end

@implementation CacheTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCache {
    // 4 cache
    self.cache = [Cache cacheWithSize:4];
    
    [self.cache put:@1 forKey:@"One"];
    XCTAssertEqualObjects(@1, [self.cache get:@"One"]);
    XCTAssertEqualObjects(@1, self.cache.list.head.obj);
    [self.cache put:@2 forKey:@"Two"];
    XCTAssertEqualObjects(@2, [self.cache get:@"Two"]);
    XCTAssertEqualObjects(@2, self.cache.list.head.obj);
    XCTAssertEqualObjects(@1, self.cache.list.head.next.obj);
    [self.cache put:@3 forKey:@"Three"];
    XCTAssertEqualObjects(@3, [self.cache get:@"Three"]);
    XCTAssertEqualObjects(@3, self.cache.list.head.obj);
    XCTAssertEqualObjects(@2, self.cache.list.head.next.obj);
    XCTAssertEqualObjects(@1, self.cache.list.head.next.next.obj);
    [self.cache put:@4 forKey:@"Four"];
    XCTAssertEqualObjects(@4, [self.cache get:@"Four"]);
    XCTAssertEqualObjects(@4, self.cache.list.head.obj);
    XCTAssertEqualObjects(@3, self.cache.list.head.next.obj);
    XCTAssertEqualObjects(@2, self.cache.list.head.next.next.obj);
    XCTAssertEqualObjects(@1, self.cache.list.head.next.next.next.obj);
    [self.cache put:@5 forKey:@"Five"];
    XCTAssertEqualObjects(@5, [self.cache get:@"Five"]);
    XCTAssertNil([self.cache get:@"One"]);
    XCTAssertEqualObjects(@5, self.cache.list.head.obj);
    XCTAssertEqualObjects(@4, self.cache.list.head.next.obj);
    XCTAssertEqualObjects(@3, self.cache.list.head.next.next.obj);
    XCTAssertEqualObjects(@2, self.cache.list.head.next.next.next.obj);
    XCTAssertEqualObjects(@3, [self.cache get:@"Three"]);
    XCTAssertEqualObjects(@3, self.cache.list.head.obj);
    XCTAssertEqualObjects(@5, self.cache.list.head.next.obj);
    XCTAssertEqualObjects(@4, self.cache.list.head.next.next.obj);
    XCTAssertEqualObjects(@2, self.cache.list.head.next.next.next.obj);
}

@end
