//
//  DiscountObject.m
//  table
//
//  Created by Anna Balytska on 4/2/13.
//  Copyright (c) 2013 softserve. All rights reserved.
//

#import "DiscountObject.h"

@implementation DiscountObject

- (void)dealloc
{
    [_name release];
    [_address release];
    [_pulse release];
    [_discount release];
    [super dealloc];
}

@end
