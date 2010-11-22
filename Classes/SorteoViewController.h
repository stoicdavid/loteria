//
//  SorteoViewController.h
//  Loteria
//
//  Created by David Rodriguez on 15/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sorteo.h"
#import "Boleto.h"
#import "XMLParserBoleto.h"

@interface SorteoViewController : UIViewController<UITextFieldDelegate> {
	
	Sorteo *sort;
	IBOutlet UILabel *nombreSorteo;
	IBOutlet UILabel *signo;
	IBOutlet UITextField *signoTexto;
	IBOutlet UITextField *numSorteoTexto;
	IBOutlet UITextField *numBoletoTexto;
	IBOutlet UIButton *enviar;
	NSSet *sorteosEsp;
	Boleto *boleto;
	BOOL botonActivo;
	CGFloat animatedDistance;
	
	//Variables para la conexion
	NSMutableData *datos;
	XMLParserBoleto *parser;
	

}

@property (assign) IBOutlet UILabel *nombreSorteo;
@property (assign) IBOutlet UILabel *signo;
@property (assign) IBOutlet UITextField *signoTexto;
@property (assign) IBOutlet UITextField *numSorteoTexto;
@property (assign) IBOutlet UITextField *numBoletoTexto;
@property (nonatomic,retain) NSMutableData *datos;

- (id)initWithNibName:(NSString *)nibNameOrNil sorteo:(Sorteo *)sorteo;

- (IBAction) consultaResultado;


@end
