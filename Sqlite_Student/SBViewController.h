//
//  SBViewController.h
//  Sqlite_Student
		
//  Created by Lion User on 02/11/2014.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>			

@interface SBViewController : UIViewController
{
    __weak IBOutlet UIImageView *imgHinh;
    __weak IBOutlet UILabel *lblMaSo;
    __weak IBOutlet UILabel *lblTen;
    __weak IBOutlet UILabel *lblNgaySinh;
    __weak IBOutlet UILabel *lblQueQuan;
    __weak IBOutlet UILabel *lblSoDienThoai;
    
    NSMutableArray *danhSachSV;
    NSMutableArray *chiTietSV;
    int n;
}
- (IBAction)setNext:(id)sender;
@end
