//
//  RootViewController.h
//  Loteria
//
//  Created by David Rodriguez on 14/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParser.h"
#import "Sorteo.h"

@interface RootViewController : UITableViewController {

	UITableViewCell *celda;
	@private 
	NSMutableArray *listaSorteos;

}

@property (retain) NSMutableArray *listaSorteos;

@property (nonatomic, retain) IBOutlet UITableViewCell *celda;
- (void)agregarSorteos:(NSArray *)sorteos;

@end
