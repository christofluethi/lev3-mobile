//
//  ResultItem.h
//  lev3-mobile
//
//  Created by Christof Luethi on 16.06.14.
//  Copyright (c) 2014 shaped.ch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultItem : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *dossId;
@property (nonatomic, strong, readonly) NSString *dossNr;
@property (nonatomic, strong, readonly) NSString *leid;

/**
 init a new ResultItem
 */
-(id)initWithName:(NSString*)name dossid:(NSString *)dossid dossnr:(NSString *)dossnr leid:(NSString *)leid;
@end
