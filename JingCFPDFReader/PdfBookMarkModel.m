//
//  PdfBookMarkModel.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfBookMarkModel.h"
static NSString * const KEY_BOOKMARK_PAGENAME = @"bookmark_pagename";
static NSString * const KEY_BOOKMARK_INTRODUCTION = @"bookmark_introduction";
@implementation PdfBookMarkModel

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.pageNumber forKey:KEY_BOOKMARK_PAGENAME];
    [aCoder encodeObject:self.introduction forKey:KEY_BOOKMARK_INTRODUCTION];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if(self){
        self.pageNumber = [aDecoder decodeObjectForKey:KEY_BOOKMARK_PAGENAME];
        self.introduction = [aDecoder decodeObjectForKey:KEY_BOOKMARK_INTRODUCTION];
    }
    return self;
}
@end
