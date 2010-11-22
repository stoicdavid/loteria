//
//  Boleto.h
//  Loteria
//
//  Created by David Rodriguez on 20/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Boleto : NSObject {
	NSNumber *nosorteo;
	NSNumber *noboleto;
	NSString *signo;
	BOOL ganador;
	NSNumber *sorteoId;
	NSString *tipo;
	NSString *cantidad;
	NSMutableArray *series;

	
}

@property (nonatomic, retain) NSNumber *nosorteo;
@property (nonatomic, retain) NSNumber *noboleto;
@property (nonatomic, copy) NSString *signo;
@property BOOL ganador;
@property (nonatomic, retain) NSNumber *sorteoId;
@property (nonatomic, copy) NSString *tipo;
@property (nonatomic, copy) NSString *cantidad;
@property (nonatomic, retain) NSMutableArray *series;

- (id)init;
- (void) agregarSerie:(NSMutableDictionary *)serie;

@end
