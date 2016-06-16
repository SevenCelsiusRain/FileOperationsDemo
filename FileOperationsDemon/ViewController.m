//
//  ViewController.m
//  FileOperationsDemon
//
//  Created by SevenCelsius on 16/6/16.
//  Copyright © 2016年 SevenCelsius. All rights reserved.
//

#import "ViewController.h"

#define HOME_PATH  NSHomeDirectory()  // 获取沙河路径

// 获取Documents路径
#define DOCUMENTS_PATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

// 获取Library路径
#define LIBRARY_PATH  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]

// 获取tmp路径
#define TMP_PATH  NSTemporaryDirectory()


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@", HOME_PATH);
    [self parsePath];
    [self creatFolder];
    [self writeImage];
}

// 获取沙河路径
- (NSString *)getHomePath {
    
    NSString *homePath = NSHomeDirectory();
    
    return homePath;
    
}

// 获取Documents路径
- (NSString *)getDocumentsPath {
    
    /*
     NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory directory, NSSearchPathDomainMask domainMask, BOOL expandTilde);
     
     directory
     NSSearchPathDirectory类型的enum值，表明我们要搜索的目录名称（NSDocumentDirectory、NSCachesDirectory。
     
     domainMask
     NSSearchPathDomainMask类型的enum值，指定搜索范围，这里的NSUserDomainMask表示搜索的范围限制于当前应用的沙盒目录。还可以写成NSLocalDomainMask（表示/Library）、NSNetworkDomainMask（表示/Network）等。
     
     expandTilde
     BOOL值，表示是否展开波浪线~。我们知道在iOS中~的全写形式是/User/userName，该值为YES即表示写成全写形式，为NO就表示直接写成“~”。
     */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return docPath;
}

// 获取Library路径
- (NSString *) getLibraryPath {
    
    NSString *libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    
    return libPath;
}

// 获取tmp路径
- (NSString *) getTmpPath {
    
    
    NSString *tmpPath = NSTemporaryDirectory();
    
    return tmpPath;
}

// 获取缓存路径
- (NSString *)getCachePath {
    
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

- (void) parsePath {

    NSString *path = @"/Users/sevencelsius/Desktop/SwiftStudy/FileOperationsDemon/FileOperationsDemon/images.jpg";
    // 获取路径的各个组成部分
    NSArray *array = [path pathComponents];
    NSLog(@"各个部分：%@", array);
    
    // 提取路径的最后一个组成部分
    NSString *name = [path lastPathComponent];
    NSLog(@"提取最后部分：%@", name);
    // 删除路径最后一个组成部分
    NSString *string = [path stringByDeletingLastPathComponent];
    NSLog(@"删除最后：%@", string);
    // 追加 一个
    NSString *addString = [path stringByAppendingPathComponent:@"name.txt"];
    NSLog(@"追加：%@", addString);
}

// 关于NSData
- (void) dataChange:(NSData *)data {
    
    // NSData ->NSString
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSData *da = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    
    UIImage *img = [[UIImage alloc] initWithData:da];
    
    NSData *imgData = UIImagePNGRepresentation(img);
    
}

/**
 文件操作
 NSFileHandle  主要对文件内容进行读取和写入操作
 NSFileManager 主要对文件操作（删除、创建等等）
 */

// 创建文件夹
- (void) creatFolder {
    
    NSString *testPath = [DOCUMENTS_PATH stringByAppendingPathComponent:@"新建文件夹"];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // withIntermediateDirectories YES:可覆盖 NO：不可覆盖
    /* attributes 属性可以设置这个参数可以设置所创建目录所属的用户和用户组，目录的访问权限和修改时间等。如果设置为nil，那么所创建目录的属性则采用系统默认设置，一般会将目录的用户设置为root，访问权限设置为0755，这样就导致其他用户向这个目录写入时失败。
     NSFileAppendOnly
     这个键的值需要设置为一个表示布尔值的NSNumber对象，表示创建的目录是否是只读的。
     
     NSFileCreationDate
     这个键的值需要设置为一个NSDate对象，表示目录的创建时间。
     
     NSFileOwnerAccountName
     这个键的值需要设置为一个NSString对象，表示这个目录的所有者的名字。
     
     NSFileGroupOwnerAccountName
     这个键的值需要设置为一个NSString对象，表示这个目录的用户组的名字。
     
     NSFileGroupOwnerAccountID
     这个键的值需要设置为一个表示unsigned int的NSNumber对象，表示目录的组ID。
     
     NSFileModificationDate
     这个键的值需要设置一个NSDate对象，表示目录的修改时间。
     
     NSFileOwnerAccountID
     这个键的值需要设置为一个表示unsigned int的NSNumber对象，表示目录的所有者ID。
     
     NSFilePosixPermissions
     这个键的值需要设置为一个表示short int的NSNumber对象，表示目录的访问权限。
     
     NSFileReferenceCount
     这个键的值需要设置为一个表示unsigned long的NSNumber对象，表示目录的引用计数，即这个目录的硬链接数。
     
     这样，通过合理的设计attributes字典中的不同键的值，这个接口所创建的目录的属性就会基本满足我们的需求了。
     */
    BOOL ret = [manager createDirectoryAtPath:testPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    if (ret) {
        
        NSLog(@"Success");
    }else {
        
        NSLog(@"Failer");
    }
    
    [self creatFile];
}

// 创建文件
- (void)creatFile {
    
     NSString *testPath = [DOCUMENTS_PATH stringByAppendingPathComponent:@"新建文件夹"];
    NSString *filePath = [testPath stringByAppendingPathComponent:@"我的笔记.txt"];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL ret = [manager createFileAtPath:filePath contents:nil attributes:nil];
    
    if (ret) {
        NSLog(@"SUccess");
    }else {
        
        NSLog(@"Failer");
    }
    
    [self writeFile:filePath];
    
}

// 写入文件
- (void)writeFile:(NSString *)filePath {
    
    NSString *content = @"写入笔记！！！！！";
    BOOL ret = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (ret) {
        NSLog(@"Success");
    }
    
    [self addFile:filePath];
}

// 文件是否存在
- (BOOL) fileExist:(NSString *)filePath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

// 追加内容
- (void) addFile:(NSString *)filePath {
    
    // 打开文件 准备更新
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    // 将文件节点跳到结尾
    [fileHandle seekToEndOfFile];
    NSData *content = [@"这是我要追加的内容" dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:content];
    [fileHandle closeFile];
    
    [self deleteFile:filePath];
    
}

// 删除
- (void)deleteFile:(NSString *)filePath {
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([self fileExist:filePath]) {
        
        BOOL ret = [manager removeItemAtPath:filePath error:nil];
        
        if (ret) {
            NSLog(@"删除成功");
        }
        
    }else {
        return;
    }
}

// 实例：图片的写入与展示
- (void)writeImage {
    NSString *testPath = [DOCUMENTS_PATH stringByAppendingPathComponent:@"新建文件夹"];
    NSString *name = [testPath stringByAppendingPathComponent:@"图片"];
    
    UIImage *img = [UIImage imageNamed:@"images.jpg"];
    NSData *data = UIImageJPEGRepresentation(img, 1000);
    [data writeToFile:name atomically:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
