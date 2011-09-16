//
//  JTJSONAppDelegate.h
//  JTJSON
//
//  Created by james on 9/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JTJSONViewController;

@interface JTJSONAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet JTJSONViewController *viewController;

@end
