//
//  LoteriaAppDelegate.m
//  Loteria
//
//  Created by David Rodriguez on 14/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "LoteriaAppDelegate.h"



@implementation LoteriaAppDelegate

@synthesize window;
@synthesize navigationController;

@synthesize lista;
@synthesize datos;

#pragma mark -
#pragma mark Application lifecycle



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	[window addSubview:navigationController.view];

	NSURL *url = [NSURL URLWithString:
				  @"http://www.lotenalweb.com:7080/resultados/sorteos.xml"];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request delegate:self];
	
	[connection release];	
	[window makeKeyAndVisible];		
	SplashView *mySplash = [[SplashView alloc] initWithImage:[UIImage imageNamed:@"im1.png"]];	


	mySplash.animation = SplashViewAnimationFade;
	mySplash.delay = 3;
	mySplash.touchAllowed = YES;
	mySplash.delegate = self;
	
	[mySplash startSplash];
	[mySplash release];
	
	
		return YES;
}

-(void)splashIsDone
	
{

	NSLog(@"Finish total");	
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	datos = [[NSMutableData alloc]init];
	[datos appendData: data];

}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
	UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle: [error localizedDescription]
							   message: [error localizedFailureReason]
							   delegate:nil
							   cancelButtonTitle:@"OK"
							   otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
	parser= [[XMLParser alloc] init];
	[parser parsearSorteos:datos];
	[self.lista agregarSorteos:parser.sorts];
	[self.lista.tableView reloadData];//aqui hago la actualización de la tabla, aunque puede utilizarse el observer
	NSLog(@"%@",lista.listaSorteos);
	[parser release];	
	
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[lista release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

