//
//  Sorteo.h
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sorteo : NSObject {
	NSMutableArray *numeroSorteo;
	NSString *nombre;
	NSString *descripcion;
	BOOL flag;
	NSInteger sorteoId;
	NSString *imagen;

}
@property (nonatomic, readwrite) NSInteger sorteoId;
@property (nonatomic, copy) NSString *nombre;
@property (nonatomic, copy) NSString *descripcion;
@property (nonatomic, copy) NSString *imagen;
@property (nonatomic, retain) NSMutableArray *numeroSorteo;
@property BOOL flag;

@end
