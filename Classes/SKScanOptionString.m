/*
 This file is licensed under the FreeBSD-License.
 For details see https://www.gnu.org/licenses/license-list.html#FreeBSD
 
 Copyright 2011 Manfred Kroehnert. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are
 permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of
 conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list
 of conditions and the following disclaimer in the documentation and/or other materials
 provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY <COPYRIGHT HOLDER> ''AS IS'' AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the
 authors and should not be interpreted as representing official policies, either expressed
 or implied, of Manfred Kroehnert.
 */

#import "SKScanOptionString.h"


@implementation SKScanOptionString

-(id) initWithStringValue:(NSString*) aString optionName:(NSString*) theName optionIndex:(NSInteger) theIndex
{
	self = [super initWithName: theName andIndex: theIndex];
    if (self)
    {
    	value = [aString retain];
        stringConstraints = nil;
    }
    return self;
}


-(void) dealloc
{
    if (value)
    {
        [value release];
        value = nil;
    }
    if (stringConstraints)
    {
        [stringConstraints release];
        stringConstraints = nil;
    }

    [super dealloc];
}


-(NSString*) description
{
	return [NSString stringWithFormat:@"Option: %@, Value: %@[%@]: %@", name, value, unitString, stringConstraints];
}


-(void*) value
{
	stringValue = [(NSString*)value UTF8String];
    return (void*)stringValue;
}


-(void) setStringConstraints:(NSArray*) anArray
{
    NSEnumerator* anEnumerator = [anArray objectEnumerator];
    id anObject = nil;
    while (anObject = [anEnumerator nextObject]) {
        if (! [anObject isKindOfClass: [NSString class]] )
        {
            [NSException raise: @"WrongArgumentType"
                        format: @"This method needs an array of String values as parameter"];
        }
    }

    if (stringConstraints)
        [stringConstraints release];
    stringConstraints = [anArray retain];
}


-(NSArray*) stringConstraints
{
    return [[stringConstraints retain] autorelease];
}


-(BOOL) isString
{
	return YES;
}


-(void) setStringValue:(NSString*) aString
{
    if (readOnly || inactive)
    {
        NSLog(@"Trying to set readonly/inactive option %@", title);
        return;
    }
    
    if (stringConstraints && ![stringConstraints containsObject: aString])
    {
        [NSException raise: @"WrongArgument"
                    format: @"The parameter needs to be one of %@ but is (%@)", stringConstraints, aString];
    }
    if (value)
        [value release];
	value = [aString retain];
}

@end
