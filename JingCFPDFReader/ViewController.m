//
//  ViewController.m
//  JingCFPDFReader
//
//  Created by jing on 17/2/24.
//  Copyright © 2017年 jing. All rights reserved.
//

#import "ViewController.h"
#import "BookNameManager.h"
#import "PdfImageManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    for (NSString *bookName in [BookNameManager AndroidBookNames]) {
        PdfImageManager *manager = [[PdfImageManager alloc] initWithLocationFileName:bookName];
        NSArray *arr = @[[manager pdfFirstImage]];
//        NSArray *arr = [manager pdfImageArray];
        NSLog(@"image count = %ld",arr.count);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
