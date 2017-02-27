//
//  PdfImageManager.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfImageManager.h"
@interface PdfImageManager (){
    CGPDFDocumentRef _pdfRef;
}

@end

@implementation PdfImageManager
- (instancetype)initWithLocationFileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        NSString *filePath = [self getPdfPathByFile:fileName];
        _pdfRef = [self pdfRefByFilePath:filePath];
    }
    return self;
}
- (instancetype)initWithFileURLString:(NSString *)fileURLString{
    self = [super init];
    if (self) {
        _pdfRef = [self pdfRefByDataByUrl:fileURLString];
    }
    return self;
}
- (UIImage *)pdfFirstImage{
    return [self imageFromPDFWithDocumentRef:_pdfRef];
}
- (UIImage *)pdfImageByIndex:(NSInteger)index{
    return [self imageFromPDFWithDocumentRef:_pdfRef AndCurrentIndex:index];
}
- (NSInteger)pdfTotlaCount{
    return [self numberOfPdfTotalCountWithDocumentRef:_pdfRef];
}
- (NSArray *)pdfImageArray{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger total = [self numberOfPdfTotalCountWithDocumentRef:_pdfRef];
    for (int i=1; i<total; i++) {
        UIImage *image =[self imageFromPDFWithDocumentRef:_pdfRef AndCurrentIndex:i];
        [array addObject:image];
    }
    return array;
}

#pragma mark CGPDFDocumentRef相关
//获取本地 pdf 文件路径
- (NSString *)getPdfPathByFile:(NSString *)fileName
{
    return [[NSBundle mainBundle] pathForResource:fileName ofType:@".pdf"];
}
//用于网络pdf文件
- (CGPDFDocumentRef)pdfRefByDataByUrl:(NSString *)aFileUrl
{
    NSData *pdfData = [NSData dataWithContentsOfFile:aFileUrl];
    CFDataRef dataRef = (__bridge_retained CFDataRef)(pdfData);
    
    CGDataProviderRef proRef = CGDataProviderCreateWithCFData(dataRef);
    CGPDFDocumentRef pdfRef = CGPDFDocumentCreateWithProvider(proRef);
    
    CGDataProviderRelease(proRef);
    CFRelease(dataRef);

    return pdfRef;
}
//用于本地pdf文件
- (CGPDFDocumentRef)pdfRefByFilePath:(NSString *)aFilePath
{
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    
    path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
    document = CGPDFDocumentCreateWithURL(url);
    
    CFRelease(path);
    CFRelease(url);
    
    return document;
}

#pragma mark pdf解析相关
//获取pdf的页码数
- (NSInteger)numberOfPdfTotalCountWithDocumentRef:(CGPDFDocumentRef)documentRef{
    size_t count = CGPDFDocumentGetNumberOfPages(documentRef);//这个位置主要是获取pdf页码数；
    return (NSInteger)count;
}
//获取第一页的内容
- (UIImage *)imageFromPDFWithDocumentRef:(CGPDFDocumentRef)documentRef {
    return [self imageFromPDFWithDocumentRef:documentRef AndCurrentIndex:1];
}
//获取指定页的内容
- (UIImage *)imageFromPDFWithDocumentRef:(CGPDFDocumentRef)documentRef AndCurrentIndex:(NSInteger)currentIndex{
    CGPDFPageRef pageRef = CGPDFDocumentGetPage(documentRef, currentIndex);
    CGRect pageRect = CGPDFPageGetBoxRect(pageRef, kCGPDFCropBox);
    UIGraphicsBeginImageContext(pageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, CGRectGetMinX(pageRect),CGRectGetMaxY(pageRect));
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, -(pageRect.origin.x), -(pageRect.origin.y));
    CGContextDrawPDFPage(context, pageRef);
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}
@end
