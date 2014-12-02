//
//  TFHppleStringTest.m
//  HppleDemo
//
//  Created by Vytautas Galaunia on 11/25/14.
//
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TFHpple.h"

@interface TFHppleStringTest : XCTestCase

@property (nonatomic, strong) TFHpple *doc;

@end

@implementation TFHppleStringTest

- (void)setUp {
    [super setUp];
    
    NSString *htmlString = @"String with a link <a href=\"http://www.google.com\">This is a link</a> and the end";
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    self.doc = [[TFHpple alloc] initWithHTMLData:data];
}

- (void)testTextNodeCount
{
    NSArray *textNodes = [self.doc searchWithXPathQuery:@"//text()"];
    XCTAssertEqual(textNodes.count, 3);
}

- (void)testFirstTextNodeContent
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//text()"];
    XCTAssertEqualObjects([e content], @"String with a link ");
}

- (void)testALinkContent
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//a"];
    XCTAssertEqualObjects([e content], @"This is a link");
    
}

- (void)testHref
{
    TFHppleElement *e = [self.doc peekAtSearchWithXPathQuery:@"//a"];
    XCTAssertEqualObjects([e objectForKey:@"href"], @"http://www.google.com");
}

@end
