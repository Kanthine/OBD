//
//  ControlPatternRightView.m
//  OBD
//
//  Created by 苏沫离 on 2017/5/10.
//  Copyright © 2017年 苏沫离. All rights reserved.
//

#define ItemIdentifer @"ControlPatternCell"
#define HeaderIdentifer @"ControlPatternSectionHeaderView"
#define ItemHeight 25

#import "ControlPatternRightView.h"



@interface ControlPatternSectionHeaderView : UICollectionReusableView

@property (nonatomic ,strong) UILabel *titleLable;

@end

@implementation ControlPatternSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(@0);
             make.left.mas_equalTo(@10);
             make.bottom.mas_equalTo(@0);
             make.right.mas_equalTo(@0);
         }];

    }
    
    return self;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc]init];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLable;
    
}


@end




@interface ControlPatternCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,assign) BOOL isWhiteBack;

@end

@implementation ControlPatternCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [self.contentView addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.mas_equalTo(@0);
             make.left.mas_equalTo(@0);
             make.bottom.mas_equalTo(@0);
             make.right.mas_equalTo(@0);
         }];
    }
    
    return self;
}

- (UILabel *)titleLable
{
    if (_titleLable == nil)
    {
        _titleLable = [[UILabel alloc]init];
        _titleLable.backgroundColor = [UIColor clearColor];
        _titleLable.textColor = [UIColor whiteColor];
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
    
}

- (void)setIsWhiteBack:(BOOL)isWhiteBack
{
    if (isWhiteBack)
    {
        self.backgroundColor = [UIColor whiteColor];
        _titleLable.textColor = RGBA(232, 106, 90, 1);
    }
    else
    {
        _titleLable.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    
    _isWhiteBack = isWhiteBack;
}

@end





















@interface ControlPatternRightView()
<UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSInteger _section1_SelectedRow;
    NSInteger _section2_SelectedRow;
}

@property (nonatomic ,strong) UIView *headerView;

@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSArray<NSArray *> *dataArray;

@end


@implementation ControlPatternRightView

- (instancetype)initWithConfigurationModel:(BoxControlAutoModelConfiguration *)configurationModel
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = RGBA(232, 106, 90, 1);
        self.frame = CGRectMake(ScreenWidth, 0, ScreenWidth / 2.0, ScreenHeight - 64);
        
        _configurationModel = configurationModel;
        //设置默认选中行
        [self setCollectionDefaultValue];

        __weak __typeof__(self) weakSelf = self;

        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        
    }
    
    return self;
}

- (NSArray<NSArray *> *)dataArray
{
    if (_dataArray == nil)
    {
        _dataArray = @[@[@"1000",@"1500",@"2000",@"2500",@"3000",@"3500",@"4000",@"4500",@"5000",@"5500",@"6000"],
  @[@"1S",@"2S",@"3S",@"4S",@"5S",@"6S",@"7S",@"8S",@"9S",@"10S"]];
    }
    
    return _dataArray;
}

- (UIView *)headerView
{
    if (_headerView == nil)
    {
        UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, -50, CGRectGetWidth(self.frame), 50)];
        headerView.backgroundColor = [UIColor clearColor];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [UIImage imageNamed:self.configurationModel.autoSelectedLogoString];
        imageView.tag = 1;
        [headerView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.equalTo(headerView.mas_centerY);
            make.width.mas_equalTo(40);
            make.height.mas_equalTo(40);
        }];
        
        UILabel *lable = [[UILabel alloc]init];
        lable.tag = 2;
        lable.textColor = [UIColor whiteColor];
        lable.font = [UIFont systemFontOfSize:15];
        lable.text = self.configurationModel.autoNameString;
        [headerView addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.left.equalTo(imageView.mas_right).with.offset(10);
            make.centerY.equalTo(imageView.mas_centerY);
            make.right.mas_equalTo(-2);
        }];
        
        
        _headerView = headerView;
    }
    
    return _headerView;
}


- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        CGFloat cellWidth = (CGRectGetWidth(self.frame) - 30) / 2.0;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(cellWidth,ItemHeight);
        layout.minimumLineSpacing = 5;//行间距
        layout.minimumInteritemSpacing = 10;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = RGBA(232, 106, 90, 1);

        
        [collectionView registerClass:[ControlPatternCell class] forCellWithReuseIdentifier:ItemIdentifer];
        [collectionView registerClass:[ControlPatternSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifer];
        
        
        [collectionView addSubview:self.headerView];
        collectionView.contentInset = UIEdgeInsetsMake(CGRectGetHeight(self.headerView.frame), 0, ScreenHeight * 162 / 750.0, 0);
        
        
        _collectionView = collectionView;
    }
    
    return _collectionView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(150, ItemHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    ControlPatternSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifer forIndexPath:indexPath];

    if (indexPath.section == 0)
    {
        headerView.titleLable.text = @"设置转速";
    }
    else
    {
        headerView.titleLable.text = @"阀门延迟";
    }
    
    return headerView;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ControlPatternCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifer forIndexPath:indexPath];
    
    NSArray *array = self.dataArray[indexPath.section];
    cell.titleLable.text = array[indexPath.row];
    
    
    if ((indexPath.section == 0 && _section1_SelectedRow == indexPath.row) ||
        (indexPath.section == 1 && _section2_SelectedRow == indexPath.row) )
    {
        cell.isWhiteBack = YES;
    }
    else
    {
         cell.isWhiteBack = NO;
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = self.dataArray[indexPath.section];
    NSString *item = array[indexPath.row];
    
    NSLog(@"item ========= %@",item);
    
    if (indexPath.section == 0)
    {
        if (indexPath.row != _section1_SelectedRow)
        {
            ControlPatternCell *oldCell = (ControlPatternCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_section1_SelectedRow inSection:0]];
            oldCell.isWhiteBack = NO;

            
            ControlPatternCell *newCell = (ControlPatternCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newCell.isWhiteBack = YES;
            
            _section1_SelectedRow = indexPath.row;
            
            _configurationModel.rotateSpeedStr = item;


        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row != _section2_SelectedRow)
        {
            ControlPatternCell *oldCell = (ControlPatternCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_section2_SelectedRow inSection:1]];
            oldCell.isWhiteBack = NO;
            
            ControlPatternCell *newCell = (ControlPatternCell *)[collectionView cellForItemAtIndexPath:indexPath];
            newCell.isWhiteBack = YES;
            
            
            _configurationModel.valveDelayStr = item;
            

            
            _section2_SelectedRow = indexPath.row;
            
        }
    }
    
    

}


#pragma mark - 修改信息


- (void)setCollectionDefaultValue
{
    __weak __typeof__(self) weakSelf = self;

    //设置默认值
    NSArray<NSString *> *speedArray = self.dataArray[0];
    [speedArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if ([obj isEqualToString:weakSelf.configurationModel.rotateSpeedStr])
         {
             _section1_SelectedRow = idx;
             
             * stop = YES;
         }
     }];
    
    
    NSArray<NSString *> *section2Array = self.dataArray[1];
    [section2Array enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
     {
         if ([obj isEqualToString:weakSelf.configurationModel.valveDelayStr])
         {
             _section2_SelectedRow = idx;
             
             * stop = YES;
         }
     }];
}


@end
