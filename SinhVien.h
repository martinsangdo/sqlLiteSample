//
//  SinhVien.h
//  Sqlite_Student
//
//  Created by Lion User on 02/11/2014.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SinhVien : NSObject
{
    NSInteger *id_SinhVien;
    NSString *tenSinhVien;
    NSString *ngaySinh;
    NSString *queQuan;		
    NSString *soDienThoai;
    UIImage *hinhSinhVien;
}
@property(nonatomic, assign) NSInteger *id_SinhVien;
@property(nonatomic, retain) NSString *tenSinhVien;
@property(nonatomic, retain) NSString *ngaySinh;
@property(nonatomic, retain) NSString *queQuan;
@property(nonatomic, retain) NSString *soDienThoai;
@property(nonatomic, retain) UIImage *hinhSinhVien;
@end
