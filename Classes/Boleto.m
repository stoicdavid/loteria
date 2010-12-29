//
//  Boleto.m
//  Loteria
//
//  Created by David Rodriguez on 20/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "Boleto.h"


@implementation Boleto

@synthesize nosorteo,noboleto,signo,ganador,sorteoId,tipo,cantidad,series,fecha;

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
	NSMutableString *print = [NSMutableString stringWithFormat:@"Número de Sorteo: %@ \nFecha: %@",nosorteo,fecha];
	
	NSString *encabezado = [NSString stringWithFormat:@"\nBillete\t\t\tSerie\t\t\tCachito$\t\t\t\t\t\t\t\t\tSerie$"];
	
	
	NSMutableString *cadenaSerie = [NSMutableString stringWithFormat:@"\n"];
	NSLog(@"%@",series);
	for (NSDictionary *serie in series){
		
		if ([serie objectForKey:@"nombre"] == nil) {
			return print;
		}
		[cadenaSerie appendString:[NSString stringWithFormat:@"%@\t\t\t",noboleto]];
		[cadenaSerie appendString:[[serie objectForKey:@"nombre"] stringByPaddingToLength:7 withString:@"\t" startingAtIndex:0]];
		NSNumber *cach = [NSNumber numberWithInt:[[serie objectForKey:@"cachito"] intValue]];
		
		[cadenaSerie appendString:[[NSNumberFormatter localizedStringFromNumber:cach numberStyle:NSNumberFormatterCurrencyStyle] 
									stringByPaddingToLength:13 withString:@"\t" startingAtIndex:0]];
		NSNumber *cant = [NSNumber numberWithInt:[[serie objectForKey:@"cantidad"] intValue]];		
		[cadenaSerie appendString:[NSNumberFormatter localizedStringFromNumber:cant numberStyle:NSNumberFormatterCurrencyStyle]];
		[cadenaSerie appendString:@"\n"];
	}
	
		 [print appendString:encabezado];
		 [print appendString:cadenaSerie];
		 return print;	 
	//return [NSString stringWithFormat:@" Número de Sorteo: %@ \n Fecha: %@ \n Billete \t Serie \t Cachito $ \t Serie $ \n %@ \t %@ \t \t \t \t %@ \t \t \t %@\t \t",
		//	nosorteo,fecha,noboleto,[[series objectAtIndex:0] objectForKey:@"nombre"],[[series objectAtIndex:1] objectForKey:@"cantidad"],cantidad];
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
