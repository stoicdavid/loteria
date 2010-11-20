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
	NSMutableArray *listaSorteos;

}

@property (nonatomic,retain) NSMutableArray *listaSorteos;
- (void)agregarSorteos:(NSArray *)sorteos;

@end
