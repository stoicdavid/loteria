//
//  ResultadoViewController.h
//  Loteria
//
//  Created by David Rodriguez on 06/12/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Boleto.h"

@interface ResultadoViewController : UIViewController {
	Boleto *ticket;
	IBOutlet UIButton *terminar;
	IBOutlet UILabel *header1;
	IBOutlet UILabel *header2;
	IBOutlet UILabel *xml;
	IBOutlet UILabel *sorteo;

}

@property (assign) IBOutlet UILabel *header1;
@property (assign) IBOutlet UILabel *header2;
@property (assign) IBOutlet UILabel *xml;
@property (assign) IBOutlet UILabel *sorteo;

- (id)initWithNibName:(NSString *)nibNameOrNil bol:(Boleto *)boleto;

- (IBAction) regresar;

@end
