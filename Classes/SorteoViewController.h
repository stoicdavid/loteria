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
#import "ResultadoViewController.h"

@interface SorteoViewController : UIViewController<UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource> {
	
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
	int signoId;
	CGFloat animatedDistance;
	NSArray *signos;
	
	//Variables para la conexion
	NSMutableData *datos;
	XMLParserBoleto *parser;
	NSString *post;
	

}

@property (assign) IBOutlet UILabel *nombreSorteo;
@property (assign) IBOutlet UILabel *signo;
@property (assign) IBOutlet UITextField *signoTexto;
@property (assign) IBOutlet UITextField *numSorteoTexto;
@property (assign) IBOutlet UITextField *numBoletoTexto;
@property (nonatomic,retain) NSMutableData *datos;
@property (nonatomic,retain) NSArray *signos;
@property (nonatomic,copy) NSString *post;
 
- (id)initWithNibName:(NSString *)nibNameOrNil sorteo:(Sorteo *)sorteo;

- (IBAction) consultaResultado;


@end
