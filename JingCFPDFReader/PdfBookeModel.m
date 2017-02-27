
//
//  PdfBookeModel.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/27.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "PdfBookeModel.h"

static NSString * const KEY_BOOKNAME_NAME = @"bookname_nameString";
static NSString * const KEY_BOOKNAME_FILENAME = @"bookname_fileNameString";
@implementation PdfBookeModel

#pragma mark - NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.nameString forKey:KEY_BOOKNAME_NAME];
    [aCoder encodeObject:self.fileNameString forKey:KEY_BOOKNAME_FILENAME];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    PdfBookeModel *model = [[PdfBookeModel alloc] init];
    model.nameString = [aDecoder decodeObjectForKey:KEY_BOOKNAME_NAME];
    model.fileNameString = [aDecoder decodeObjectForKey:KEY_BOOKNAME_FILENAME];
    return model;
}
@end
