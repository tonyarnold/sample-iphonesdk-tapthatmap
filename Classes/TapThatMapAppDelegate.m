/*
 *  TapThatMapAppDelegate.m
 *  TapThatMap
 *
 *  Created on 16/04/10 by Tony Arnold of The CocoaBots - http://thecocoabots.com/
 *  This code is licensed under a Creative Commons Attribution 2.5 license - http://creativecommons.org/licenses/by/2.5/
 *
 */

#import "TapThatMapAppDelegate.h"
#import "TapThatMapViewController.h"

@implementation TapThatMapAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	/* Override point for customization after app launch */
	[window addSubview:viewController.view];
	[window makeKeyAndVisible];

	return YES;
}

- (void)dealloc {
	[viewController release];
	[window release];
	[super dealloc];
}

@end
