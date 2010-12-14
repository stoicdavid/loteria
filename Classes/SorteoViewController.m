//
//  SorteoViewController.m
//  Loteria
//
//  Created by David Rodriguez on 15/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "SorteoViewController.h"



@implementation SorteoViewController

@synthesize nombreSorteo;
@synthesize signo,signos;
@synthesize datos,post;
@synthesize signoTexto,numBoletoTexto,numSorteoTexto;

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

#define SIGNOS @"Aries", @"Tauro", @"Géminis", @"Cancer", @"Leo", @"Virgo", @"Libra", @"Escorpio", @"Capricornio", @"Acuario",@"Piscis", nil

#define SORTEOS_ESPECIALES @"4", nil

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil sorteo:(Sorteo *)sorteo{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nil])) {
		sorteosEsp = [[[NSSet alloc] initWithObjects:SORTEOS_ESPECIALES] autorelease];
		sort = sorteo;
		NSLog(@"%@",sort);
		botonActivo=NO;
				
    }
    return self;
}

- (IBAction) consultaResultado
{

	NSURL *url = [NSURL URLWithString:
				  @"http://www.lotenal.gob.mx:8080/buscador/buscador-premios-xml.jsp"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	//[self loadRequest:request];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	if (sort.sorteoId == 4) {
		post = [NSString stringWithFormat:@"CmbSorteo=%i&CmbSigZod=%i&NumSorteo=%@&boleto=%@",sort.sorteoId,signoId,numSorteoTexto.text,numBoletoTexto.text];
	}else {
		post = [NSString stringWithFormat:@"CmbSorteo=%i&NumSorteo=%@&boleto=%@",sort.sorteoId,numSorteoTexto.text,numBoletoTexto.text];
	}
	NSLog(@"%@",post);
	NSString *msjLong = [NSString stringWithFormat:@"%d",[post length]];
	
	[request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
	[request addValue:msjLong forHTTPHeaderField:@"Content-Length"];
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
	

	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request delegate:self];
	
	[connection release];	
	
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
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[errorAlert show];
	[errorAlert release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
	parser= [[XMLParserBoleto alloc] init];
	[parser parsearBoletos:datos];
	//NSLog(@"%@",parser.boleto);
	boleto = parser.boleto;
	//[self.lista agregarSorteos:parser.sorts];
	[parser release];
	//NSLog(@"La cantidad es %@",boleto.cantidad);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	ResultadoViewController *resultado = [[ResultadoViewController alloc]initWithNibName:@"ResultadoViewController" bol:boleto];
	resultado.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
	[self presentModalViewController:resultado animated:YES];
	//[resultado release];	
	[datos release];	
}


-(void)touchesBegan: (NSSet *)touches withEvent:(UIEvent *)event
{
	// do the following for all textfields in your current view
	[numBoletoTexto resignFirstResponder];
	[numSorteoTexto resignFirstResponder];
	[signoTexto resignFirstResponder];
	// save the value of the textfield, ...
	
}


#pragma mark Métodos del UITextFieldDelegateProtocol 
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{ 
	[textField resignFirstResponder]; 
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect textFieldRect =
	[self.view.window convertRect:textField.bounds fromView:textField];
    CGRect viewRect =
	[self.view.window convertRect:self.view.bounds fromView:self.view];
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    CGFloat numerator =
	midline - viewRect.origin.y
	- MINIMUM_SCROLL_FRACTION * viewRect.size.height;
    CGFloat denominator =
	(MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION)
	* viewRect.size.height;
    CGFloat heightFraction = numerator / denominator;
	
	if (heightFraction < 0.0)
    {
        heightFraction = 0.0;
    }
    else if (heightFraction > 1.0)
    {
        heightFraction = 1.0;
    }
	
	UIInterfaceOrientation orientation =
	[[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
    }
    else
    {
        animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    }
	
	CGRect viewFrame = self.view.frame;
    viewFrame.origin.y -= animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
	enviar.enabled=YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    
    [self.view setFrame:viewFrame];
    
    [UIView commitAnimations];
}




#pragma mark viewDelegateProtocol


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Consulta tu resultado";
	nombreSorteo.text =sort.nombre;
	if (![sorteosEsp containsObject:[NSString stringWithFormat:@"%i",sort.sorteoId]]) {
		signo.hidden=YES;
		signoTexto.hidden=YES;
	}
	if ([numBoletoTexto.text isEqual:@""]) {
		enviar.enabled = botonActivo;
	}
	numBoletoTexto.delegate=self;
	numBoletoTexto.returnKeyType=UIReturnKeyDone;
	UIPickerView *signoPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    signoPicker.delegate = self;
    signoPicker.dataSource = self;
    [signoPicker setShowsSelectionIndicator:YES];
	signoTexto.inputView = signoPicker;
	[signoPicker release];
	
	numSorteoTexto.delegate=self;
	numSorteoTexto.returnKeyType=UIReturnKeyDone;
	
	signos = [[NSArray alloc]initWithObjects:SIGNOS];

	
	
}


#pragma mark -

#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [signos objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	signoTexto.text = (NSString *)[signos objectAtIndex:row];
	signoId=row+1;

}

#pragma mark -

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return signos.count;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[signos release];
	[sort release];
	//[sorteosEsp release];
    [super dealloc];
}


@end
