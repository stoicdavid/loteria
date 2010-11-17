//
//  SplashView.m
//  Loteria
//
//  Created by David Rodriguez on 15/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "SplashView.h"


@implementation SplashView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)dismissSplash {

	CABasicAnimation *animSplash = [CABasicAnimation animationWithKeyPath:@"opacity"];
	animSplash.duration = .7;
	animSplash.removedOnCompletion = NO;
	animSplash.fillMode = kCAFillModeForwards;
	animSplash.toValue = [NSNumber numberWithFloat:0];
	animSplash.delegate = self;
	[self.layer addAnimation:animSplash forKey:@"animateOpacity"];
	
	
	
	
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	[self removeFromSuperview];
}


- (void)dealloc {
    [super dealloc];
}


@end
