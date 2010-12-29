//
//  ResultadoViewController.m
//  Loteria
//
//  Created by David Rodriguez on 06/12/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "ResultadoViewController.h"


@implementation ResultadoViewController

@synthesize header1,header2,xml,contenedor;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/
- (id)initWithNibName:(NSString *)nibNameOrNil bol:(Boleto *)boleto{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nil])) {
		ticket = boleto;
		terminar.enabled = NO;
		
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	if (ticket.ganador) {
		header1.text = @"¡Felicidades!";
		header2.text = @"Ya ganaste";
		//NSLog(@"%@",ticket);
		xml.text = [NSString stringWithFormat:@"%@", ticket];
	}else {
		header1.text = @"Lo sentimos";
		header2.text = @"¡Sigue participando!";
		xml.text= @"\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\tVisita nuestro sitio web en \n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\thttp://www.lotenal.gob.mx";
		
	}
	//sorteo.text = ticket.tipo;


	
}


- (IBAction) informacion{
	NSURL *target = [[NSURL alloc] initWithString:@"http://www.lotenal.gob.mx/index.php"];
    [[UIApplication sharedApplication] openURL:target];
}

- (IBAction) regresar{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)agregaImagen:(UIImage *)imagen{
	contenedor.image=imagen;
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[ticket release];
	[contenedor release];
    [super dealloc];
}


@end
