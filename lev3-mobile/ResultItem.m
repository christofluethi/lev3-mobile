//
//  ResultItem.m
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import "ResultItem.h"

@implementation ResultItem
-(id)initWithName:(NSString*)name dossid:(NSString*)dossid dossnr:(NSString*)dossnr leid:(NSString*)leid {
    self = [super init];
    
    if(self) {
        _name = name;
        _dossId = dossid;
        _dossNr = dossnr;
        _leid = leid;
    }
    
    return self;
}

@end
