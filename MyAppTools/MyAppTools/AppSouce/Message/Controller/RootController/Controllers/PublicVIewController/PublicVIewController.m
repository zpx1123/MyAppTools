//
//  PublicVIewController.m
//  MyAppTools
//
//  Created by 周鹏翔 on 16/8/15.
//  Copyright © 2016年 周鹏翔. All rights reserved.
//

#import "PublicVIewController.h"
#import "InfiniteLoopViewBuilder.h"
#import "LoopViewCell.h"
#import "LoopTypeTwoCell.h"
#import "NodeStateView.h"
#import "ImageModel.h"
#import "CircleNodeStateView.h"
#import "InfiniteLoopModel.h"
#import "MyLayout.h"
static NSInteger sBaseTag = 100000;

@interface PublicVIewController ()<InfiniteLoopViewBuilderEventDelegate>
@property(nonatomic, strong) MyLinearLayout *rootLayout;
@property(nonatomic,strong)NSMutableArray * dataSouceArrs;
@property(nonatomic,strong)NSMutableArray * dataSouceArrs1;
@end

@implementation PublicVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInfiniteLoopView];
    [self addSectionLayout:1];
    [self addSectionLayout0];
    [self addSectionLayout1];
    
    // Do any additional setup after loading the view.
}
- (void)addInfiniteLoopView {
    
    
    {
        NSArray *strings = @[@"http://img.wdjimg.com/image/video/d999011124c9ed55c2dd74e0ccee36ea_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2ddcad6dcc38c5ca88614b7c5543199a_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/6d6ccfd79ee1deac2585150f40915c09_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2111a863ea34825012b0c5c9dec71843_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/b4085a983cedd8a8b1e83ba2bd8ecdd8_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/2d59165e816151350a2b683b656a270a_0_0.jpeg",
                             @"http://img.wdjimg.com/image/video/dc2009ee59998039f795fbc7ac2f831f_0_0.jpeg"];
        
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < strings.count; i++) {
            
            ImageModel *model                     = [ImageModel imageModelWithImageUrl:strings[i]];
            
            // Setup model.
            model.infiniteLoopCellClass           = [LoopViewCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
            [models addObject:model];
        }
        
        InfiniteLoopViewBuilder *loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, Width, 130)];
        loopView.nodeViewTemplate   = [CircleNodeStateView new];
        loopView.delegate           = self;
        loopView.sampleNodeViewSize = CGSizeMake(8, 6);
        loopView.position           = kNodeViewBottomRight;
        loopView.edgeInsets         = UIEdgeInsetsMake(0, 0, 7, 5);
        loopView.models             = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        [loopView startLoopAnimated:YES];
        loopView.myTopMargin=1;
        loopView.widthDime.equalTo(self.rootLayout.widthDime).multiply(1);
        loopView.heightDime.equalTo(@130);
        [self.rootLayout addSubview:loopView];
        
        UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, loopView.width, 20)];
        blackView.bottom          = loopView.height;
        blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
        [loopView.contentView addSubview:blackView];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//其他布局
-(void)loadView
{
    UIScrollView *scrollView = [UIScrollView new];
    self.view = scrollView;
    
    self.rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    self.rootLayout.myLeftMargin = self.rootLayout.myRightMargin = 0;
    self.rootLayout.gravity = MyMarginGravity_Horz_Fill;
    self.rootLayout.backgroundColor = [UIColor colorWithWhite:0xe7/255.0 alpha:1];
    self.rootLayout.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]]; //设置智能边界线，布局里面的子视图会根据布局自动产生边界线。
    [scrollView addSubview:self.rootLayout];
}

-(void)addSectionLayout0{
    
    
    
    NSDictionary * dic0=@{@"title":@"报表统计",
                          @"image":@"main_menu_1",
                          @"class":@"ReportStatisticsVC"};
    
    NSDictionary * dic1=@{@"title":@"诉求填报",
                          @"image":@"main_menu_2",
                          @"class":@"WriteReqReportVC"};
    
    NSDictionary * dic2=@{@"title":@"诉求办理",
                          @"image":@"main_menu_3",
                          @"class":@"ApplyReqReportVC"};
    
    NSDictionary * dic3=@{@"title":@"企业运行指标",
                          @"image":@"main_menu_4",
                          @"class":@"EnterpriseStandardVC"};
    

    
    [self.dataSouceArrs addObject:dic0];
    [self.dataSouceArrs addObject:dic1];
    [self.dataSouceArrs addObject:dic2];
    [self.dataSouceArrs addObject:dic3];
    
    UILabel *sectionTitleLabel = [UILabel new];
    sectionTitleLabel.text = @"title2";
    sectionTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    sectionTitleLabel.backgroundColor = [UIColor whiteColor];
    sectionTitleLabel.myHeight = 30;
    sectionTitleLabel.myTopMargin = 10;
    [self.rootLayout addSubview:sectionTitleLabel];
    
    //添加单元格容器视图
    MyFlowLayout *cellContainerLayout = [self createCellContainerLayout:2];
    //    cellContainerLayout.myBottomMargin = 10;
    [_rootLayout addSubview:cellContainerLayout];
    
    
    for (NSInteger j = 0; j < self.dataSouceArrs.count; j++)
    {
        UIView *cellLayout = [self createCellLayout1:[self.dataSouceArrs[j] objectForKey:@"image"]
                                               title:[self.dataSouceArrs[j] objectForKey:@"title"]];
        cellLayout.tag = sBaseTag *j + j; //用于确定所在的辅助编号和单元格编号。
        
        [cellContainerLayout addSubview:cellLayout];
    }

}
-(void)addSectionLayout1{
    
    NSDictionary * dic1=@{@"title":@"诉求填报",
                          @"image":@"main_menu_2",
                          @"class":@"WriteReqReportVC"};
    
    NSDictionary * dic2=@{@"title":@"诉求办理",
                          @"image":@"main_menu_3",
                          @"class":@"ApplyReqReportVC"};
    
    NSDictionary * dic3=@{@"title":@"企业运行指标",
                          @"image":@"main_menu_4",
                          @"class":@"EnterpriseStandardVC"};
    
    
    
    [self.dataSouceArrs1 addObject:dic1];
    [self.dataSouceArrs1 addObject:dic2];
    [self.dataSouceArrs1 addObject:dic3];
    UILabel *sectionTitleLabel = [UILabel new];
    sectionTitleLabel.text = @"title3";
    sectionTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    sectionTitleLabel.backgroundColor = [UIColor whiteColor];
    sectionTitleLabel.myHeight = 30;
    sectionTitleLabel.myTopMargin = 10;
    [self.rootLayout addSubview:sectionTitleLabel];
    
    //添加单元格容器视图
    MyFlowLayout *cellContainerLayout = [self createCellContainerLayout:3];
    //    cellContainerLayout.myBottomMargin = 10;
    [_rootLayout addSubview:cellContainerLayout];
    
    
    for (NSInteger j = 0; j < self.dataSouceArrs1.count; j++)
    {
        UIView *cellLayout = [self createCellLayout1:[self.dataSouceArrs1[j] objectForKey:@"image"]
                                               title:[self.dataSouceArrs1[j] objectForKey:@"title"]];
        cellLayout.tag = sBaseTag *j + j; //用于确定所在的辅助编号和单元格编号。
        
        [cellContainerLayout addSubview:cellLayout];
    }
    
}

#pragma mark -- Layout Construction


//创建单元格容器布局视图，并指定每行的数量。
-(MyFlowLayout*)createCellContainerLayout:(NSInteger)arrangedCount
{
    MyFlowLayout *containerLayout = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:arrangedCount];
    containerLayout.wrapContentHeight = YES;
    containerLayout.averageArrange = YES; //平均分配里面每个子视图的宽度或者拉伸子视图的宽度以便填充满整个布局。
    containerLayout.subviewHorzMargin = 1;
    containerLayout.subviewVertMargin = 1;
    containerLayout.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    
    return containerLayout;
}

//创建单元格布局视图，其中的高度固定为100
-(UIView*)createCellLayout1:(NSString*)image title:(NSString*)title{
    
    //建立一个相对布局
    MyRelativeLayout *cellLayout = [MyRelativeLayout new];
    cellLayout.padding = UIEdgeInsetsMake(5, 5, 5, 5);
    cellLayout.myLeftMargin=cellLayout.myRightMargin=0;
    cellLayout.myHeight = MYDIMESCALEW(150);
    cellLayout.backgroundColor = [UIColor whiteColor];
    [cellLayout setTarget:self action:@selector(handleCellLayoutTap:)];
    cellLayout.highlightedOpacity = 0.3; //设置触摸事件按下时的不透明度，来响应按下状态。
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    imageView.centerXPos.equalTo(cellLayout.centerXPos);  //垂直居中
    imageView.centerYPos.equalTo(cellLayout.centerYPos);  //垂直居中
    //    [imageView sizeToFit];
    imageView.myHeight=50;
    imageView.myWidth=50;
    
    [cellLayout addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.topPos.equalTo(imageView.bottomPos).offset(8);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    //    titleLabel.myBottomMargin = 2;
    titleLabel.centerXPos.equalTo(cellLayout.centerXPos);  //垂直居中
    [titleLabel sizeToFit];
    [cellLayout addSubview:titleLabel];
    
    
    
    
    
    return cellLayout;
    
}

//添加片段布局
-(void)addSectionLayout:(NSInteger)sectionIndex{
    
    UILabel *sectionTitleLabel = [UILabel new];
    sectionTitleLabel.text = @"title";
    sectionTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    sectionTitleLabel.backgroundColor = [UIColor whiteColor];
    sectionTitleLabel.myHeight = 30;
    sectionTitleLabel.myTopMargin = 10;
    [self.rootLayout addSubview:sectionTitleLabel];
    
    
//    MyFlowLayout *containerLayout = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:arrangedCount];
//    containerLayout.wrapContentHeight = YES;
//    containerLayout.averageArrange = YES; //平均分配里面每个子视图的宽度或者拉伸子视图的宽度以便填充满整个布局。
//    containerLayout.subviewHorzMargin = 1;
//    containerLayout.subviewVertMargin = 1;
//    containerLayout.padding = UIEdgeInsetsMake(0, 5, 5, 5);
    
    //创建条目容器布局。
    MyFloatLayout *itemContainerLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Vert ];
    itemContainerLayout.backgroundColor = [UIColor whiteColor];
    itemContainerLayout.wrapContentHeight = YES;
    
    itemContainerLayout.IntelligentBorderLine = [[MyBorderLineDraw alloc] initWithColor:[UIColor lightGrayColor]];
    [self.rootLayout addSubview:itemContainerLayout];
    
    for (int i=0; i<4; i++) {
        MyBaseLayout *itemLayout = [self createItemLayout5_1:nil];
        itemLayout.backgroundColor=[UIColor grayColor];
//        itemLayout.widthDime.equalTo(@50);
        itemLayout.widthDime.equalTo(itemContainerLayout.widthDime).multiply(0.25);
        itemLayout.heightDime.equalTo(@120);
        [itemContainerLayout addSubview:itemLayout];
    }
    MyBaseLayout *itemLayout = [self createItemLayout5_1:nil];
    itemLayout.backgroundColor=[UIColor grayColor];
    //        itemLayout.widthDime.equalTo(@50);
    itemLayout.widthDime.equalTo(itemContainerLayout.widthDime).multiply(1);
    itemLayout.heightDime.equalTo(@80);
    [itemContainerLayout addSubview:itemLayout];
 
    
    

}


//这个整体就是上下浮动布局
-(MyFloatLayout*)createItemLayout5_1:(id)dataModel
{
    MyFloatLayout *itemLayout = [MyFloatLayout floatLayoutWithOrientation:MyLayoutViewOrientation_Horz];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"标题";
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    titleLabel.myLeftMargin = 5;
    titleLabel.myTopMargin = 5;
    [titleLabel sizeToFit];
    [itemLayout addSubview:titleLabel];
    
//    UILabel *subTitleLabel = [UILabel new];
//    subTitleLabel.text = @"2222";
//    subTitleLabel.font = [UIFont systemFontOfSize:11];
//    subTitleLabel.textColor = [UIColor redColor];
//    subTitleLabel.myLeftMargin = 5;
//    subTitleLabel.myTopMargin = 5;
//    [subTitleLabel sizeToFit];
//    [itemLayout addSubview:subTitleLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"p2-4"]];
    imageView.widthDime.equalTo(itemLayout.widthDime);
    imageView.weight = 1;   //图片占用剩余的全部高度
    [itemLayout addSubview:imageView];
    
    return itemLayout;
}


- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell {
    
    NSLog(@"index:%ld - %@ %@", (long)index, data, cell);
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index {
    
    NSLog(@"currentPage:%ld", (long)index);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSMutableArray *)dataSouceArrs{
    
    if (_dataSouceArrs==nil) {
        _dataSouceArrs=[NSMutableArray array];
    }
    return _dataSouceArrs;
}
-(NSMutableArray *)dataSouceArrs1{
    
    if (_dataSouceArrs1==nil) {
        _dataSouceArrs1=[NSMutableArray array];
    }
    return _dataSouceArrs1;
}
@end
