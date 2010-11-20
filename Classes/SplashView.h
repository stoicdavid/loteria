//
//  SplashView.h
//  Loteria
//
//  Created by David Rodriguez on 15/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol SplashViewDelegate <NSObject>
@optional
- (void)splashIsDone;
@end

typedef enum {
	SplashViewAnimationNone,
	SplashViewAnimationSlideLeft,
	SplashViewAnimationFade,
} SplashViewAnimation;

@interface SplashView : UIView {

	
	id<SplashViewDelegate> delegate;
	UIImageView *splashImage;
	UIImage *image;
	NSTimeInterval delay;
	BOOL touchAllowed;
	SplashViewAnimation animation;
	NSTimeInterval animationDelay;
	//IBOutlet UIActivityIndicatorView *activity;
	BOOL isFinishing;
	
}
@property (retain) id<SplashViewDelegate> delegate;
@property (retain) UIImage *image;
@property NSTimeInterval delay;
@property BOOL touchAllowed;
@property SplashViewAnimation animation;
@property NSTimeInterval animationDelay;
@property BOOL isFinishing;
//@property IBOutlet UIActivityIndicatorView *activity;

- (id)initWithImage:(UIImage *)screenImage;
- (void)startSplash;
- (void)dismissSplash;
- (void)dismissSplashFinish;


@end
