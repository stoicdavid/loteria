//
//  LoteriaAppDelegate.h
//  Loteria
//
//  Created by David Rodriguez on 14/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashView.h"
#import "XMLParser.h"
#import "RootViewController.h"
@class XMLParser, RootViewController;
@interface LoteriaAppDelegate : NSObject <UIApplicationDelegate,SplashViewDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	RootViewController *lista;
	XMLParser *parser;
	NSMutableData *datos;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet RootViewController *lista;
@property (nonatomic, retain) NSMutableData *datos;

@end

