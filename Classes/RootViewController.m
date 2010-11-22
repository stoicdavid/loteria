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

@synthesize listaSorteos;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
 
    [super viewDidLoad];
	
	

	self.listaSorteos = [NSMutableArray array];
	
	
	
	self.title = @"Sorteos";
	

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
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


- (void)agregarSorteos:(NSArray *)sorteos
{
	
	//[self willChangeValueForKey:@"listaSorteos"];
	[self.listaSorteos addObjectsFromArray:sorteos];
	//[self didChangeValueForKey:@"listaSorteos"];	
}

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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
	// Configure the cell.

	NSLog(@"%@",listaSorteos);
	if ([listaSorteos count]) {
		

	Sorteo *s=[listaSorteos objectAtIndex:indexPath.row];
	cell.textLabel.text = s.nombre;
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%i",s.sorteoId];
	}	
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
    

	Sorteo *s=[[Sorteo alloc]init];
	s=[listaSorteos objectAtIndex:indexPath.row];
	SorteoViewController *detailViewController = [[SorteoViewController alloc] initWithNibName:@"SorteoViewController" sorteo:s];
	
	[self.navigationController pushViewController:detailViewController animated:YES];
	
	[detailViewController release];
	[s release];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {

	self.listaSorteos = nil;
    
    [self removeObserver:self forKeyPath:@"listaSorteos"];
}


- (void)dealloc {
	[listaSorteos release];
    [super dealloc];

}


@end

