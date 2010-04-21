/*
 *  TapThatMapViewController.m
 *  TapThatMap
 *
 *  Created on 16/04/10 by Tony Arnold of The CocoaBots - http://thecocoabots.com/
 *  This code is licensed under a Creative Commons Attribution 2.5 license - http://creativecommons.org/licenses/by/2.5/
 *
 */

#import "TapThatMapViewController.h"

@interface TapThatMapViewController ()

- (void)TapThatMapViewController_registerObservers;
- (void)TapThatMapViewController_unregisterObservers;

@end


@implementation TapThatMapViewController

@synthesize myGreatMapView      = _myGreatMapView;
@synthesize locationToolbar     = _locationToolbar;
@synthesize locationButton      = _locationButton;
@synthesize isFollowingLocation = _isFollowingLocation;

/* Implement viewDidLoad to do additional setup after loading the view, typically from a nib. */
- (void)viewDidLoad {
	[super viewDidLoad];
	[self TapThatMapViewController_registerObservers];
}

/* Override to allow orientations other than the default portrait orientation. */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	/* Return YES for supported orientations */
	return YES;
}

- (void)viewDidUnload {
	[self TapThatMapViewController_unregisterObservers];
}

- (void)dealloc {
	[self TapThatMapViewController_unregisterObservers];
	[_myGreatMapView release], _myGreatMapView   = nil;
	[_locationToolbar release], _locationToolbar = nil;
	[_locationButton release], _locationButton   = nil;

	[super dealloc];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"contentOffset"]) {
		id            outerView  = [[self.myGreatMapView subviews] objectAtIndex:0];
		UIScrollView *scrollView = [[outerView subviews] objectAtIndex:0];

		if ([scrollView isKindOfClass:[UIScrollView class]]) {
			if (scrollView.dragging) {
				[self followChangesToUserLocation:NO];
			}
		}
	}
}

- (void)followChangesToUserLocation:(BOOL)newState {
	/* This method turns the user location on and off, as well as replacing the
	 * location button with a highlighted version when the method is active.
	 */

	if (newState == self.isFollowingLocation) {
		return;
	}

	self.isFollowingLocation = newState;

	UIBarButtonItem *newButton;

	if (self.isFollowingLocation) {
		/* Toggle the value on and off to trigger a refresh */
		self.myGreatMapView.showsUserLocation = NO;
		self.myGreatMapView.showsUserLocation = YES;

		newButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Stop Following Me", nil) style:UIBarButtonItemStyleDone target:self action:@selector(setMapViewToCurrentLocation:)];
	} else {
		newButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Start Following Me", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(setMapViewToCurrentLocation:)];
	}

	NSMutableArray *newItems           = [NSMutableArray arrayWithArray:self.locationToolbar.items];
	NSInteger       currentButtonIndex = [newItems indexOfObject:self.locationButton];
	[newItems replaceObjectAtIndex:currentButtonIndex withObject:newButton];
	self.locationButton        = newButton;
	self.locationToolbar.items = newItems;

	[newButton release];
}

#pragma mark -
#pragma mark Interface Builder Actions

- (IBAction)setMapViewToCurrentLocation:(id)sender {
	[self followChangesToUserLocation:!self.isFollowingLocation];
}

#pragma mark -
#pragma mark Private instance methods

- (void)TapThatMapViewController_registerObservers {
	if (_hasRegisteredObservers == NO) {
		/* I'm making assumptions (but checking them carefully) about the view
		 *  heirarchy of the MKMapView here. If the view hierarchy does not match
		 *  what I expect, then the contentOffset property will not be observed,
		 *  and the user will have to manually cancel the location updating.
		 *
		 */
		id outerView = [[self.myGreatMapView subviews] objectAtIndex:0];

		if ((outerView != nil) && [outerView isKindOfClass:[UIView class]]) {
			id scrollView = [[outerView subviews] objectAtIndex:0];

			if ((scrollView != nil) && [scrollView isKindOfClass:[UIScrollView class]]) {
				[scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:NULL];
			}
		}

		_hasRegisteredObservers = YES;
	}
}

- (void)TapThatMapViewController_unregisterObservers {
	if (_hasRegisteredObservers == YES) {
		/* I'm making assumptions (but checking them carefully) about the view
		 *  heirarchy of the MKMapView here. If the view hierarchy does not match
		 *  what I expect, then the contentOffset property will not have been
		 *  observed in the first place, so removing it will be moot.
		 *
		 */
		id outerView = [[self.myGreatMapView subviews] objectAtIndex:0];

		if ((outerView != nil) && [outerView isKindOfClass:[UIView class]]) {
			id scrollView = [[outerView subviews] objectAtIndex:0];

			if ((scrollView != nil) && [scrollView isKindOfClass:[UIScrollView class]]) {
				[scrollView removeObserver:self forKeyPath:@"contentOffset"];
			}
		}

		_hasRegisteredObservers = NO;
	}
}

@end
