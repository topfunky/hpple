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

#define TEST_DOCUMENT_NAME          @"index"
#define TEST_DOCUMENT_EXTENSION     @"html"

@interface TFHppleHTMLTest : XCTestCase

@property (nonatomic, strong) TFHpple *doc;

@end

@implementation TFHppleHTMLTest

- (void)setUp
{
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    NSURL *testFileUrl = [testBundle URLForResource:TEST_DOCUMENT_NAME withExtension:TEST_DOCUMENT_EXTENSION];
    NSData * data = [NSData dataWithContentsOfURL:testFileUrl];
    self.doc = [[TFHpple alloc] initWithHTMLData:data];
}

- (void)testInitializesWithHTMLData
{
    XCTAssertNotNil(self.doc.data);
    XCTAssertTrue([self.doc isMemberOfClass:[TFHpple class]]);
}

//  doc.search("//p[@class='posted']")
- (void)testSearchesWithXPath
{
    NSArray *a = [self.doc searchWithXPathQuery:@"//a[@class='sponsor']"];
    XCTAssertEqual([a count], 2);
    
    TFHppleElement * e = [a objectAtIndex:0];
    XCTAssertTrue([e isMemberOfClass:[TFHppleElement class]]);
}

- (void)testFindsFirstElementAtXPath
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//a[@class='sponsor']"];
    
    XCTAssertEqualObjects([e content], @"RailsMachine");
    XCTAssertEqualObjects([e tagName], @"a");
}

- (void)testSearchesByNestedXPath
{
    NSArray *a = [self.doc searchWithXPathQuery:@"//div[@class='column']//strong"];
    XCTAssertEqual([a count], 5);
    
    TFHppleElement * e = [a objectAtIndex:0];
    XCTAssertEqualObjects([e content], @"PeepCode");
}

- (void)testPopulatesAttributes
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//a[@class='sponsor']"];
    
    XCTAssertTrue([[e attributes] isKindOfClass:[NSDictionary class]]);
    XCTAssertEqualObjects([[e attributes] objectForKey:@"href"], @"http://railsmachine.com/");
}

- (void)testProvidesEasyAccessToAttributes
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//a[@class='sponsor']"];
    
    XCTAssertEqualObjects([e objectForKey:@"href"], @"http://railsmachine.com/");
}

//  doc.at("body")['onload']


//  (doc/"#elementID").inner_html


//  (doc/"#elementID").to_html

//  doc.at("div > div:nth(1)").css_path

//  doc.at("div > div:nth(1)").xpath



@end
