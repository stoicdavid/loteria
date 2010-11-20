//
//  XMLParser.h
//  Loteria
//
//  Created by David Rodriguez on 16/11/10.
//  Copyright 2010 UNAM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sorteo.h"
#import "LoteriaAppDelegate.h"



@interface XMLParser : NSObject<NSXMLParserDelegate> {
	

	NSString *currentElementName;
	NSMutableString *currentText;
	NSSet *interestingTags;
	NSMutableArray *sorts;
	Sorteo *sorteo;
//	BOOL finished;
}
//@property BOOL finished;
@property (nonatomic, retain) NSMutableArray *sorts;
-(void)parsearSorteos:(NSMutableData *)data;

@end
