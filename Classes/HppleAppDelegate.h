//
//  HppleAppDelegate.h
//  Hpple
//
//  Created by Geoffrey Grosenbach on 1/31/09.
//  Copyright Topfunky Corporation 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HppleAppDelegate : NSObject <UIApplicationDelegate> 
{
  UIWindow *window;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@end

