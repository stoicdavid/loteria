//
//  Boleto.m
//  Loteria
//
//  Created by David Rodriguez on 20/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "Boleto.h"


@implementation Boleto

@synthesize nosorteo,noboleto,signo,ganador,sorteoId,tipo,cantidad,series;

- (id) init

{
	if ((self = [super init])) {
		series = [NSMutableArray array];
		nosorteo = [NSNumber numberWithInt:0];
		noboleto = [NSNumber numberWithInt:0];
		signo = [NSString string];;
		ganador = NO;
		sorteoId = [NSNumber numberWithInt:0];
		tipo = [NSString string];
		cantidad = [NSString string];;
    }
    return self;
	
}




-(NSString*)description{
	return [NSString stringWithFormat:@"Boleto ganador:%d con numero %@ numeroSorteo %@ ",ganador,noboleto,nosorteo];
}

- (void) agregarSerie:(NSMutableDictionary *)serie
{
	[self.series addObject:serie];
}


-(void)dealloc
{
	[nosorteo release];
	[noboleto release];
	[signo release];
	[sorteoId release];
	[tipo release];
	[cantidad release];
	[series release];
	[super dealloc];
}

@end
