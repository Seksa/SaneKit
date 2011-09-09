//
//  SKScanOption.m
//  SaneKit
//
//  Created by MK on 08.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SKScanOption.h"


@implementation SKScanOption

-(id) initWithName:(NSString*) aName andIndex:(NSInteger) anIndex andValue:(id) aValue
{
	self = [super init];
    if (self)
    {
    	name = [aName retain];
        index = anIndex;
        value = [aValue copy];
    }
    return self;
}


-(void) dealloc
{
	[name release];
    [value release];
    
    [super dealloc];
}


-(NSString*) description
{
	return [NSString stringWithFormat:@"Option: %@, Value: %@", name, value];
}


@end