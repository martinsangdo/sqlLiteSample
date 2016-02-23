//
//  SBViewController.m
//  Sqlite_Student
//
//  Created by Lion User on 02/11/2014.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "SBViewController.h"
#import "SinhVien.h"
@interface SBViewController ()

@end

@implementation SBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // goi ham Show tham so truyen vao la 0;
    [self show:0];
}

-(void)show:(int)chiso
{
    // Vi ham quanLySinhVien tra ket qua ve 1 mang nen ta tao 1 mang de hung du lieu
    chiTietSV = [[NSMutableArray alloc]initWithArray:[self quanLySinhVien]];
    // Sau do ta do du lieu vao cac Label tren giao dien			
    [lblMaSo setText:[NSString stringWithFormat:@"%i",((SinhVien *) [chiTietSV objectAtIndex:chiso]).id_SinhVien]];
    [lblTen setText:[NSString stringWithFormat:@"%@",((SinhVien *) [chiTietSV objectAtIndex:chiso]).tenSinhVien]];
    [lblNgaySinh setText:[NSString stringWithFormat:@"%@",((SinhVien *) [chiTietSV objectAtIndex:chiso]).ngaySinh]];
    [lblQueQuan setText:[NSString stringWithFormat:@"%@",((SinhVien *) [chiTietSV objectAtIndex:chiso]).queQuan]]; 
    [lblSoDienThoai setText:[NSString stringWithFormat:@"%@",((SinhVien *) [chiTietSV objectAtIndex:chiso]).soDienThoai]];
    [imgHinh setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",((SinhVien *) [chiTietSV objectAtIndex:chiso]).hinhSinhVien]]];
}

-(NSMutableArray *) quanLySinhVien
{
    danhSachSV = [[NSMutableArray alloc]init];
    
    NSString *databaseName = @"student.sqlite";
    //khoi tao bien dat ten cho csdl
    
    //tim kiem file databse co ten student.sqlite    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0]; 
    NSString *databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    
    //khoi tao 1 doi tuong thuoc kieu luu tru file
    NSFileManager *fileManager = [NSFileManager defaultManager]; 
    //kiem tra file database co kiem duoc khong 
    BOOL success=[fileManager fileExistsAtPath:databasePath]; 
    if (!success) { 
        // Neu khong thanh cong
        NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName]; 
        [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];   
    }
    
    // truoc khi tuong tac co so du lieu Sqlite, ta phai tao mot bien thuoc kieu sqlite
    sqlite3 *contactDB; 
    // cai dat UTF8 cho duong dan neu ten file tieng viet
    const char *dbpath = [databasePath UTF8String];
    // dung ham sqlite3_open de mo key noi den file sqlite.
    // dung bien SQLITE_OK de kiem tra viec thuc thi ket noi co thanh cong hay khong
    if(sqlite3_open(dbpath, &contactDB)==SQLITE_OK){ 
        
        //kho it oa bien thuoc kieu cau truy van
        sqlite3_stmt *statement;
        // viet cau lenh truy van la tat ca thong tin trong bang sinh vien
        NSString *sql = @"SELECT * FROM sinhVien";
        // cai dat UTF8 cho cau lenh truy van nau trong cau lenh truy van co tieng viet
        const char *query_stmt = [sql UTF8String]; 
        //cau lenh truy van duoc khoi tao, luu tru boi doi tuong sqlite3_stmt thong qua ham sqite3_prepare_v2()
        if(sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL)==SQLITE_OK){ 
            // thu thi viec truy xuat du lieu thanh cong
            while(sqlite3_step(statement)==SQLITE_ROW){
                // khoi tao mot doi tuong thuoc lop SinhVien
                SinhVien *quanLySinhVien = [[SinhVien alloc]init];
                // lay du lieu tu database len theo cac cot trong bang
                quanLySinhVien.id_SinhVien = (int *)sqlite3_column_int(statement, 0);
                quanLySinhVien.tenSinhVien = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                quanLySinhVien.ngaySinh = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                quanLySinhVien.queQuan = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                quanLySinhVien.soDienThoai = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                quanLySinhVien.hinhSinhVien = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                //sau do ta gan vao bang
                [danhSachSV addObject:quanLySinhVien];
                //NSLog(@"%@",[danhSachSV objectAtIndex:0]);
            }
            // xoa du lieu trong bo nho cua ham sqite3_prepare_v2()	
            sqlite3_finalize(statement);
        } 
        
        
    }else{ 
        NSLog(@"Có lỗi xảy ra"); 
    } 
    return danhSachSV;
}
- (void)viewDidUnload
{
    imgHinh = nil;
    lblMaSo = nil;
    lblTen = nil;
    lblNgaySinh = nil;
    lblQueQuan = nil;
    lblSoDienThoai = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)setNext:(id)sender {
    if (++n == [chiTietSV count]) {
        n = 0;
        [self show:n];

    }
    else {

        [self show:n];
    }
}
@end
