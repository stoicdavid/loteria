//
//  XMLParser.m
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import "XMLParser.h"


@implementation XMLParser
@synthesize sorts;

#define INTERESTING_TAG_NAMES @"nombre", @"descripcion", @"image",@"id",@"numero",@"flag-extra", nil


- (XMLParser *) initXMLParser {
	
	[super init];
	
	return self;
}



#pragma mark -
#pragma mark NSURLConnection


-(void)getInfoFromServer
{
	sorteosData = [[NSMutableData alloc] init];
	NSURL *url = [NSURL URLWithString:
				  @"http://localhost:3000/sorteos.xml"];
	NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
	NSURLConnection *connection = [[NSURLConnection alloc]
								   initWithRequest:request
								   delegate:self];
	[connection release];
	[request release];
	
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[sorteosData appendData: data];
}


-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
	UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle: [error localizedDescription]
							   message: [error localizedFailureReason]
							   delegate:nil
							   cancelButtonTitle:@"OK"
							   otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}


- (void) parsearSorteos {
	NSXMLParser *sorteoParser = [[NSXMLParser alloc] initWithData:sorteosData];
	sorteoParser.delegate = self;
	[sorteoParser parse];
	[sorteoParser release];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
	[self parsearSorteos];
}


#pragma mark NSXMLParser callbacks




- (void)parserDidStartDocument:(NSXMLParser *)parser {
	
	currentElementName = nil;
	interestingTags = [[NSSet alloc] initWithObjects: INTERESTING_TAG_NAMES];
	sorts = [[NSMutableArray alloc]init];
	
	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
									    namespaceURI:(NSString *)namespaceURI
									   qualifiedName:(NSString *)qualifiedName
										  attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"sorteo"]) {
		[sorteo release];
		sorteo = [[Sorteo alloc] init];


	}
	else if ([interestingTags containsObject: elementName]) { 
		currentElementName = elementName;
		
	}
	
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:currentElementName]) {

		NSString *sel =  [@"set" stringByAppendingString:[elementName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[elementName substringToIndex:1] uppercaseString]]];
		NSString *sel2 = [sel stringByAppendingString:@":"];

		SEL setter = NSSelectorFromString(sel2);
		if ([sorteo respondsToSelector:setter]) {
			[sorteo performSelector:setter withObject:currentText];
		}
		else if	([elementName isEqualToString:@"id"]){
			NSInteger num = [currentText intValue];
			sorteo.sorteoId = num;
		}
		else if	([elementName isEqualToString:@"numero"]){
			[sorteo.numeroSorteo addObject:currentText];
		}
		else if	([elementName isEqualToString:@"flag-extra"]){
			sorteo.flag=[elementName boolValue];
		}
		
		
	} else if ([elementName isEqualToString:@"sorteo"]) {
		//NSLog(@"%@",sorteo);
		//NSString *selec = @"addObject:";
		[sorts addObject:sorteo];



		
		//NSLog(@"%@",listaSorteos.sorteos);
	
		
	}
	//[currentText release];
	currentText = nil;
	
}



- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	if (!currentText) {
		currentText = [NSMutableString string];
	}
	[currentText appendString:string];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	[interestingTags release];
	
	
	NSLog(@"%@",sorts);
}

- (void) dealloc {
	
	[sorteo release];
	[sorts release];
	
	[super dealloc];
}


@end
