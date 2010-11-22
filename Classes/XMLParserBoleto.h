//
//  XMLParser.h
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sorteo.h"

#import "Boleto.h"



@interface XMLParserBoleto : NSObject<NSXMLParserDelegate> {
	

	NSString *currentElementName;
	NSMutableString *currentText;
	NSString *currentSerie;
	NSSet *interestingTags;
	//NSMutableArray *sorts;
	NSMutableDictionary *serial;
	Boleto *boleto;
	BOOL serie;
}
//@property BOOL finished;
@property (nonatomic, retain) NSMutableArray *sorts;
@property (nonatomic, retain) Boleto *boleto;
-(void)parsearBoletos:(NSMutableData *)data;

@end
