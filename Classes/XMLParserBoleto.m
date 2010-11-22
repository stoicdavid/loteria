//
//  XMLParser.m
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "XMLParserBoleto.h"


@implementation XMLParserBoleto
@synthesize sorts;
@synthesize boleto;

#define INTERESTING_TAG_NAMES @"sorteo",@"tipo",@"cantidad",@"nosorteo",@"noboleto",@"nombre",@"serie", nil


- (XMLParserBoleto *) init{
	
	[super init];
	boleto=[[Boleto alloc]init];
	return self;
}



#pragma mark -
#pragma mark NSURLConnection


- (void) parsearBoletos:(NSMutableData *)data {
	NSXMLParser *boletoParser = [[NSXMLParser alloc] initWithData:data];
	boletoParser.delegate = self;
	[boletoParser parse];
	[boletoParser release];
}

#pragma mark NSXMLParser callbacks




- (void)parserDidStartDocument:(NSXMLParser *)parser {
	currentElementName=nil;
	currentSerie=nil;
	interestingTags = [[NSSet alloc] initWithObjects: INTERESTING_TAG_NAMES];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
									    namespaceURI:(NSString *)namespaceURI
									   qualifiedName:(NSString *)qualifiedName
										  attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"sorteo"]) {
		if ([[attributeDict objectForKey:@"ganador"] isEqualToString:@"si"]) {
			boleto.ganador=YES;
		}else {
			boleto.ganador=NO;
		}
		
	}
	else if([elementName isEqualToString:@"serie"]) {
		serial=nil;
		serial = [[NSMutableDictionary alloc] initWithCapacity:2];	
		serie=YES;
	}
	
	else if (serie){
		currentElementName = nil;	

	}

	else if ([interestingTags containsObject: elementName]) { 
		currentElementName = elementName;
		currentElementName = [currentElementName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	}
	
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:currentElementName]) {

		NSString *sel =  [@"set" stringByAppendingString:[elementName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[elementName substringToIndex:1] uppercaseString]]];
		NSString *sel2 = [sel stringByAppendingString:@":"];

		SEL setter = NSSelectorFromString(sel2);
		if ([boleto respondsToSelector:setter] && !serie) {
			[boleto performSelector:setter withObject:currentText];
		}

	}
	else if ([elementName isEqualToString:@"serie"]) 
	{
		[boleto agregarSerie:serial];
		//NSLog(@"%@",boleto.series);
		serie=NO;
	}
	
	
	else if (serie)
	{
		
		[serial setObject:currentText forKey:elementName];
		
		
	}	
//	else if([elementName isEqualToString:@"series"]){
//		NSLog(@"%@",boleto);
//	}

	else if ([elementName isEqualToString:@"sorteo"]) 
	{
		//NSLog(@"%@",sorteo);
		//NSString *selec = @"addObject:";
		//[boleto addObject:sorteo];
		
	//	NSLog(@"%@",boleto);
	
		
	}
	currentText = nil;
	
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	if (!currentText) {
		currentText = [NSMutableString string];
	}
	if (![string isEqualToString:@""]) {
			[currentText appendString:string];
	}
	
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {

	
	//NSLog(@"%@",sorts);
}

- (void)parserErrorOcurred:(NSXMLParser *)parser {
	
	
	NSLog(@"Error");
}


- (void) dealloc {
	[interestingTags release];
	[serial release];
	//[boleto release];
	//[currentElementName release];

	//[sorts release];
	
	[super dealloc];
}


@end
