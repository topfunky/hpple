//
//  XPathQuery.h
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

NSArray * _Nullable PerformHTMLXPathQuery(NSData *document, NSString *query);
NSArray * _Nullable PerformHTMLXPathQueryWithEncoding(NSData *document, NSString *query, NSString * _Nullable encoding);
NSArray * _Nullable PerformXMLXPathQuery(NSData *document, NSString *query);
NSArray * _Nullable PerformXMLXPathQueryWithEncoding(NSData *document, NSString *query, NSString * _Nullable encoding);

NS_ASSUME_NONNULL_END
