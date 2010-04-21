/*
 *  TapThatMapAppDelegate.h
 *  TapThatMap
 *
 *  Created on 16/04/10 by Tony Arnold of The CocoaBots - http://thecocoabots.com/
 *  This code is licensed under a Creative Commons Attribution 2.5 license - http://creativecommons.org/licenses/by/2.5/
 *
 */

#import <UIKit/UIKit.h>

@class TapThatMapViewController;

@interface TapThatMapAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow                 *window;
	TapThatMapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow                 *window;
@property (nonatomic, retain) IBOutlet TapThatMapViewController *viewController;

@end

