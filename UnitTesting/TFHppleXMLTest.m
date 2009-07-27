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


#import "GTMSenTestCase.h"
#import "TFHpple.h"

#define TEST_DOCUMENT_PATH @"UnitTesting/TestData/feed.rss"

@interface TFHppleXMLTest : GTMTestCase
{
  TFHpple * doc;
}
@end

@implementation TFHppleXMLTest

- (void) dealloc { [super dealloc]; }

- (void) setUp
{
  NSData * data = [NSData dataWithContentsOfFile:TEST_DOCUMENT_PATH];
  doc = [[TFHpple alloc] initWithXMLData:data];
}

- (void) tearDown
{
  [doc release];
}

- (void) testInitializesWithXMLData
{
  STAssertNotNil(doc.data, nil);
  STAssertEqualObjects([[doc class] description], @"TFHpple", nil);
}

//  item/title,description,link
- (void) testSearchesWithXPath
{
  NSArray * items = [doc search:@"//item"];
  STAssertEquals((int)[items count], 0x0f, nil);

  TFHppleElement * e = [items objectAtIndex:0];
  STAssertEqualObjects([[e class] description], @"TFHppleElement", nil);
}

- (void) testFindsFirstElementAtXPath
{
  TFHppleElement * e = [doc at:@"//item/title"];

  STAssertEqualObjects([e content], @"Objective-C for Rubyists", nil);
  STAssertEqualObjects([e tagName], @"title", nil);
}

- (void) testSearchesByNestedXPath
{
  NSArray * elements = [doc search:@"//item/title"];
  STAssertEquals((int)[elements count], 0x0f, nil); 
 
  TFHppleElement * e = [elements objectAtIndex:0];
  STAssertEqualObjects([e content], @"Objective-C for Rubyists", nil);
}

- (void) testAtSafelyReturnsNilIfEmpty
{
  TFHppleElement * e = [doc at:@"//a[@class='sponsor']"];
  
  STAssertEqualObjects(e, nil, nil);
}

// Other Hpricot methods:
//  doc.at("body")['onload']
//  (doc/"#elementID").inner_html
//  (doc/"#elementID").to_html
//  doc.at("div > div:nth(1)").css_path
//  doc.at("div > div:nth(1)").xpath

@end
