/*
 *  TapThatMapViewController.h
 *  TapThatMap
 *
 *  Created on 16/04/10 by Tony Arnold of The CocoaBots - http://thecocoabots.com/
 *  This code is licensed under a Creative Commons Attribution 2.5 license - http://creativecommons.org/licenses/by/2.5/
 *
 */

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface TapThatMapViewController : UIViewController {
	@private
	BOOL             _hasRegisteredObservers;
	MKMapView       *_myGreatMapView;
	UIToolbar       *_locationToolbar;
	UIBarButtonItem *_locationButton;
	BOOL             _isFollowingLocation;
}

@property (nonatomic, retain, readwrite) IBOutlet MKMapView       *myGreatMapView;
@property (nonatomic, retain, readwrite) IBOutlet UIToolbar       *locationToolbar;
@property (nonatomic, retain, readwrite) IBOutlet UIBarButtonItem *locationButton;
@property (nonatomic, assign, readwrite) BOOL                      isFollowingLocation;

- (void)followChangesToUserLocation:(BOOL)newState;
- (IBAction)setMapViewToCurrentLocation:(id)sender;

@end

