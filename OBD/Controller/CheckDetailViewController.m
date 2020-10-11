//
//  CheckDetailViewController.m
//  OBD
//
//  Created by Why on 16/4/1.
//  Copyright © 2016年 Why. All rights reserved.
//

#import "CheckDetailViewController.h"

@interface CheckDetailViewController ()
@property (strong, nonatomic) UITextView *textView;
@end

@implementation CheckDetailViewController
{
    NSArray * _messageArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.backImageView.image = [UIImage imageNamed:@"kaiguan_beijing"];
    self.title = self.titleStr;
    [self.view addSubview:self.textView];
    _messageArray = @[WHYGetStringWithKeyFromTable(@"TEXTDRIVETIME", @""),WHYGetStringWithKeyFromTable(@"TEXTINTAKEPRESSURE", @""),WHYGetStringWithKeyFromTable(@"TEXTENGINELOAD", @""),WHYGetStringWithKeyFromTable(@"TEXTINTAKEFLUE", @""),WHYGetStringWithKeyFromTable(@"TEXTFEATSOPENING", @""),WHYGetStringWithKeyFromTable(@"TEXTKONGRANBI", @""),WHYGetStringWithKeyFromTable(@"TEXTCARSPEED", @""),WHYGetStringWithKeyFromTable(@"TEXTOILLOSS", @""),WHYGetStringWithKeyFromTable(@"TEXTINTAKETEMP", @""),WHYGetStringWithKeyFromTable(@"TEXTAVERGEOILLOSS", @""),WHYGetStringWithKeyFromTable(@"TEXTDRIVEDISTANCE", @""),WHYGetStringWithKeyFromTable(@"TEXTAVERGESPEED", @""),WHYGetStringWithKeyFromTable(@"TEXTDAISUSHIJIAN", @"")];
   // self.textView.text = _messageArray[self.index];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 10;
    NSDictionary * attributex = @{NSFontAttributeName:[UIFont systemFontOfSize:14],NSParagraphStyleAttributeName:paragraphStyle,NSForegroundColorAttributeName:[UIColor whiteColor]};
   //_textView.textColor = [UIColor whiteColor];
     _textView.attributedText = [[NSAttributedString alloc]initWithString:_messageArray[self.index] attributes:attributex];
}
- (UITextView*)textView{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 64, ScreenWidth-20, ScreenHeight-64)];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.textColor = [UIColor whiteColor];
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor clearColor];
        
       
    //    [self.view addSubview:_textView];
    }
    return _textView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
