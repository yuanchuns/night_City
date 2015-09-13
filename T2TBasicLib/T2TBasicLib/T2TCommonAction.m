//
//  T2TCommonAction.m
//  T2TBasicLib
//
//  Created by mark on 14/12/12.
//  Copyright (c) 2014年 mark. All rights reserved.
//

#import "T2TCommonAction.h"

@implementation T2TCommonAction
#pragma mark -

+(void)setView:(UIView *)v disEnabledFor:(float)time{
    if(![v isKindOfClass:[UIView class]]) return;
    v.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        v.userInteractionEnabled = YES;
    });
}


#pragma mark -  字符串占位处理

+(float)widthWithFont:(UIFont *)font str:(NSString *)str{
    
    CGSize size;
    if (kIsIOS7) {
    size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil]];
    }else{
        size = [str sizeWithFont:font];
    }

    return size.width;
}

+(void)setViewBorder:(UIView *)view{

    if (view) {
        view.layer.masksToBounds = YES;
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = kLineColor.CGColor;
    }
    
}

+ (float)getAttributedStringHeightWithString:(NSAttributedString *) string WidthValue:(int) width
{
    
    CGRect rt = [string boundingRectWithSize:CGSizeMake(width, 100000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    //(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
    return rt.size.height;
    
}


//设置行间距
+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(float) h {
    return [self atsForStr:str lineHeight:h forCompute:NO];
}


+(NSMutableAttributedString *)atsForStr:(NSString *)str lineHeight:(float) h forCompute:(BOOL)forCompute{
    if (![str isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = forCompute?NSLineBreakByCharWrapping:NSLineBreakByTruncatingTail;
    [paragraphStyle setLineSpacing:h];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    return attributedString;
}


//获取设置行间距的NSAttributedString的高度

+(float)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(float)w lineH:(float )lh{
    if (![str isKindOfClass:[NSString class]]) {
        return 0;
    }
    NSMutableAttributedString *attributedString = [self atsForStr:str lineHeight:lh forCompute:YES];
    [attributedString addAttribute:NSFontAttributeName value:ft range:NSMakeRange(0, str.length)];
    float height = [self getAttributedStringHeightWithString:attributedString WidthValue:w]+0.5;//这个0.5是黑体的误差
    if (height<ft.pointSize*2+lh) {
        height = ft.lineHeight;
    }
    return height;
}
//获取字符串显示的高度
+(float)heightFoStr:(NSString *)str font:(UIFont *)ft width:(float)w{
    if (![str isKindOfClass:[NSString class]]) {
        return 0;
    }
    if (kIsIOS7) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
        [attributedString addAttribute:NSFontAttributeName value:ft range:NSMakeRange(0, str.length)];
        return [self getAttributedStringHeightWithString:attributedString WidthValue:w];
        //        return heightForAtsFontWidth(attributedString,ft,w);
    }else{
        CGSize s = [str sizeWithFont:ft constrainedToSize:CGSizeMake(w, 100000)];
        return s.height;
    }
}

+(float)heightForAtsWithStr:(NSString *)str font:(UIFont *)ft width:(float)w lineH:(float)lineGap maxLine:(NSUInteger)lineNum{
    float heightOfAll = [self heightForAtsWithStr:str font:ft width:w lineH:lineGap];
    NSString *strTem = @"a";
    for (int i=0; i<lineNum-1; i++) {
        strTem = [strTem stringByAppendingString:@"\na"];
    }
    float heightOfMax = [self heightForAtsWithStr:strTem font:ft width:w lineH:lineGap];
    return MIN(heightOfAll, heightOfMax);
}

+(float)heightFoStr:(NSString *)str font:(UIFont *)ft width:(float)w maxLine:(NSUInteger)lineNum{
    float heightOfAll = [self heightFoStr:str font:ft width:w];
    NSString *strTem = @"a";
    for (int i=0; i<lineNum; i++) {
        strTem = [strTem stringByAppendingString:@"\na"];
    }
    float heightOfMax = [self heightFoStr:strTem font:ft width:w];
    return MIN(heightOfAll, heightOfMax);
}

//获取给定size的换行符
+(NSString *)strOfLineForSize:(CGSize)s withFont:(UIFont *)ft{
    
    NSString *str = @"";
    float h = [self heightFoStr:@"\n\n\n\n\n\n\n\n\n\n" font:ft width:300];
    for (int i=0; i<ceilf(s.height*10/h); i++) {
        str = [str stringByAppendingString:@"\n"];
    }
    return str;
    
}

+(NSString *)strOfSpaceForWidth:(float)width withFont:(UIFont *)ft{
    if (width<=0) {
        return @"";
    }
    NSString *str = @" ";
    float w = [str sizeWithFont:ft].width;
    NSUInteger num = ceilf(width/w);
    for (int i=1; i<num; i++) {
        str = [str stringByAppendingString:@" "];
    }
    return str;
}

#pragma mark -

+(NSIndexPath *)indexPathForCellSubView:(UIView *)sv fromTable:(UITableView *)table{
    if(![sv isKindOfClass:[UIView class]]) return nil;
    UIView *vTem = sv;
    while (vTem.superview && ![vTem isKindOfClass:[UITableViewCell class]]) {
        vTem = vTem.superview;
    }
    //    if(![vTem isKindOfClass:[UITableViewCell class]]) return nil;
    UITableViewCell *cell = (UITableViewCell *)vTem;// (UITableViewCell *)(kIsIOS7?sv.superview.superview:sv.superview);
    if(![cell isKindOfClass:[UITableViewCell class]]) return nil;
    NSIndexPath *indexp = [table indexPathForCell:cell];
    return indexp;
}

//根据cell的子视图获取cell的row
+(NSUInteger)rowForCellSubView:(UIView *)sv fromTable:(UITableView *)table{
    NSIndexPath *idp = [self indexPathForCellSubView:sv fromTable:table];
    if([idp isKindOfClass:[NSIndexPath class]]) return idp.row;
    return 0;
}
//根据cell的子视图获取cell的section
+(NSUInteger)sectionForCellSubView:(UIView *)sv fromTable:(UITableView *)table{
    NSIndexPath *idp = [self indexPathForCellSubView:sv fromTable:table];
    if([idp isKindOfClass:[NSIndexPath class]]) return idp.section;
    return 0;
}


#pragma mark -


+(NSString *)pathForResourceWithBundleName:(NSString *)strBundleName fileName:(NSString *)fileName{
    NSString *resourcePath = [[NSBundle mainBundle]resourcePath];
   [TLog log:resourcePath];
    NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:strBundleName withExtension:@"bundle"]];
    [TLog log:[bundle description]];
    NSString *filePath = [bundle pathForResource:fileName ofType:@""];
    
    if (!filePath) {
        [TLog logErrorInfo:[NSString stringWithFormat:@"#no resource for fileName:%@ Bundle:%@",fileName,[bundle description]]];
    }
    return filePath;
}


#pragma mark -

+(void)saveImg:(UIImage *)img{
    if (![img isKindOfClass:[UIImage class]]) {
        return;
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:kCurrentWindow animated:YES];
    HUD.labelText = @"正在保存";
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library saveImage:img toAlbum:@"233网教" withCompletionBlock:^(NSError *error) {
        [TLog log:[error description]];
        if (!error) {
            [T2TView showOKHUDWithHUD:HUD test:@"已保存到手机相册"];
        }else{
            [HUD hide:YES];
            [[[UIAlertView alloc]initWithTitle:@"无法保存" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kAppName] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
        }
    }];
    
    return;
    
    [MBProgressHUD showHUDAddedTo:kCurrentWindow animated:YES].labelText = @"正在保存";
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}

+(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    [MBProgressHUD hideHUDForView:kCurrentWindow animated:YES];
    if (error != NULL){
        [[[UIAlertView alloc]initWithTitle:@"无法保存" message:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片",kAppName] delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
    else{
        [T2TView showOKHUDWithText:@"已保存到手机相册"];
    }
}

#pragma mark -


+(NSString *)dateStringForFormat:(NSString *)format timeInterval:(double)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:format];
    return [f stringFromDate:date];
}

#pragma mark - 限定输入长度
+(void)limitTextFiledLength:(UITextField *)textFiled withLen:(NSUInteger)length{
    
    bool isChinese;//判断当前输入法是否是中文
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        //iOS8 下有和好的方法 请及时的修改
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    NSString *str = [textFiled.text stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textFiled markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
//            NSLog(@"汉字");
            if ( str.length >= length) {
                NSString *strNew = [NSString stringWithString:str];
                [textFiled setText:[strNew substringToIndex:length]];
            }
        }
        else
        {
            NSLog(@"输入的英文还没有转化为汉字的状态");
        }
    }else{
        // NSLog(@"str=%@; 本次长度=%d",str,[str length]);
        if ([str length]>length) {
            NSString *strNew = [NSString stringWithString:str];
            [textFiled setText:[strNew substringToIndex:length]];
        }
    }
}

+(void)limitTextViewLength:(UITextView *)textView withLen:(NSUInteger)length{
    
    bool isChinese;//判断当前输入法是否是中文
    if ([[[UITextInputMode currentInputMode] primaryLanguage] isEqualToString: @"en-US"]) {
        isChinese = false;
    }
    else
    {
        isChinese = true;
    }
    
    NSString *str = [textView.text stringByReplacingOccurrencesOfString:@"?" withString:@""];
    if (isChinese) { //中文输入法下
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
//            NSLog(@"汉字");
            if ( str.length >= length) {
                NSString *strNew = [NSString stringWithString:str];
                [textView setText:[strNew substringToIndex:length]];
            }
        }
        else
        {
            NSLog(@"输入的英文还没有转化为汉字的状态");
            
        }
    }else{
        // NSLog(@"str=%@; 本次长度=%d",str,[str length]);
        if ([str length]>length) {
            NSString *strNew = [NSString stringWithString:str];
            [textView setText:[strNew substringToIndex:length]];
        }
    }
}


@end
