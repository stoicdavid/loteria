//
//  Sorteo.m
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "Sorteo.h"


@implementation Sorteo

@synthesize nombre,descripcion,sorteoId,numeroSorteo,imagen,flag;


-(NSString*)description{
	return [NSString stringWithFormat:@"Nombre %@ con numero %i imagen %@ descripcion:%@",nombre,sorteoId,imagen,descripcion];
}

-(void)dealloc
{
	[nombre release];
	[descripcion release];
	[numeroSorteo release];
	[imagen release];
	[super dealloc];
}

@end
