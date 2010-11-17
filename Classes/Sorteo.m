//
//  Sorteo.m
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "Sorteo.h"


@implementation Sorteo

@synthesize nombre,descripcion,sorteoId,numeroSorteo,image,flag;


-(NSString*)description{
	return [NSString stringWithFormat:@"Sorteo %@ con numero %i imagen %@ descripcion:%@",nombre,sorteoId,image,descripcion];
}

-(void)dealloc
{
	[nombre release];
	[descripcion release];
	[numeroSorteo release];
	[image release];
	[super dealloc];
}

@end
