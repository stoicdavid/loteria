//
//  RootViewController.m
//  Loteria
//
//  Created by David Rodriguez on 14/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "RootViewController.h"
#import "SorteoViewController.h"


@implementation RootViewController

@synthesize listaSorteos,celda;

#pragma mark -
#pragma mark View lifecycle

- (void)agregarSorteos:(NSArray *)sorteos
{
	
	//[self willChangeValueForKey:@"listaSorteos"];
	[listaSorteos addObjectsFromArray:sorteos];
	//[self didChangeValueForKey:@"listaSorteos"];	
}

- (void)viewDidLoad {
 
    [super viewDidLoad];
	listaSorteos = [[NSMutableArray alloc]init];
	self.title = @"Sorteos";
	

    // Uncomment the following line to display an Edit but
	//ton in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	[self addObserver:self forKeyPath:@"listaSorteos" options:0 context:NULL];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

	
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];


}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}


/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */




// para los cambios en la interfaz no se usa por ahora
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listaSorteos count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"CeldaSorteo"
									  owner:self options:NULL]; 
		cell = celda;
		
		self.celda= nil;
	}

		Sorteo *lot=[listaSorteos objectAtIndex:indexPath.row];
		UIImageView *sorteoImagen = (UIImageView *) [cell viewWithTag:1]; 
		sorteoImagen.image = lot.imagenURL;

    return cell;

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //[listaSorteos retain];
	
	//[listaSorteos retain];
	SorteoViewController *detailViewController = [[SorteoViewController alloc] 
												  initWithNibName:@"SorteoViewController" 
														   sorteo: [listaSorteos objectAtIndex:[indexPath row]]];
	
	[self.navigationController pushViewController:detailViewController animated:YES];
	detailViewController=nil;
	[detailViewController release];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; // your dynamic height...
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

	//self.listaSorteos = nil;
    
    [self removeObserver:self forKeyPath:@"listaSorteos"];
}


- (void)dealloc {

	[listaSorteos release];
    [super dealloc];

}


@end

