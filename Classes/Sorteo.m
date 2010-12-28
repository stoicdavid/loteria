//
//  Sorteo.m
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "Sorteo.h"


@implementation Sorteo

@synthesize nombre,descripcion,sorteoId,numeroSorteo,imagenURL,flag;


-(NSString*)description{
	return [NSString stringWithFormat:@"Nombre %@ con numero %i imagen %@ descripcion:%@",nombre,sorteoId,imagenURL,descripcion];
}

-(void)dealloc
{
	[nombre release];
	[descripcion release];
	[numeroSorteo release];
	[imagenURL release];
	[super dealloc];
}

@end
