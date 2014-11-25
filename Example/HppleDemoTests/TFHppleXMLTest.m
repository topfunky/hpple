//
//  TFHppleTest.m
//  Hpple
//
//  Created by Geoffrey Grosenbach on 1/31/09.
//
//  Copyright (c) 2009 Topfunky Corporation, http://topfunky.com
//
//  MIT LICENSE
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "TFHpple.h"

#define TEST_DOCUMENT_NAME          @"feed"
#define TEST_DOCUMENT_EXTENSION     @"rss"

@interface TFHppleXMLTest : XCTestCase

@property (nonatomic, strong) TFHpple *doc;

@end

@implementation TFHppleXMLTest

- (void)setUp
{
    [super setUp];
    
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *testFileUrl = [testBundle URLForResource:TEST_DOCUMENT_NAME withExtension:TEST_DOCUMENT_EXTENSION];
    NSData * data = [NSData dataWithContentsOfURL:testFileUrl];
    self.doc = [[TFHpple alloc] initWithXMLData:data];
}


- (void)testInitializesWithXMLData
{
    XCTAssertNotNil(self.doc.data);
    XCTAssertTrue([self.doc isMemberOfClass:[TFHpple class]]);
}

//  item/title,description,link
- (void)testSearchesWithXPath
{
    NSArray *items = [self.doc searchWithXPathQuery:@"//item"];
    XCTAssertEqual([items count], 0x0f);
    
    TFHppleElement * e = [items objectAtIndex:0];
    XCTAssertTrue([e isMemberOfClass:[TFHppleElement class]]);
}

- (void)testFindsFirstElementAtXPath
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//item/title"];
    
    XCTAssertEqualObjects([e content], @"Objective-C for Rubyists");
    XCTAssertEqualObjects([e tagName], @"title");
}

- (void)testSearchesByNestedXPath
{
    NSArray *elements = [self.doc searchWithXPathQuery:@"//item/title"];
    XCTAssertEqual([elements count], 0x0f);
    
    TFHppleElement * e = [elements objectAtIndex:0];
    XCTAssertEqualObjects([e content], @"Objective-C for Rubyists");
}

- (void)testAtSafelyReturnsNilIfEmpty
{
    TFHppleElement * e = [self.doc peekAtSearchWithXPathQuery:@"//a[@class='sponsor']"];
    XCTAssertEqualObjects(e, nil);
}

// Other Hpricot methods:
//  doc.at("body")['onload']
//  (doc/"#elementID").inner_html
//  (doc/"#elementID").to_html
//  doc.at("div > div:nth(1)").css_path
//  doc.at("div > div:nth(1)").xpath

@end
