//
//  ViewController.m
//  TLServicePlatform
//
//  Created by 周鹏翔 on 16/7/4.
//  Copyright © 2016年 周鹏翔. All rights reserved.
//

#import "TLServierViewController.h"
#import "MyLayout.h"
#import "UINavigationController+Push_Pop.h"
static NSInteger sBaseTag = 100000;


@interface TLServierViewController ()
@property(nonatomic,strong) MyLinearLayout *rootLayout;
@property(nonatomic,strong)NSMutableArray * dataSouceArrs;
@end

@implementation TLServierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1] ;
    self.title=@"首页";
    
    [self addViews];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addViews{
    
    // 1025    报表统计 企业运行指标
    // 102201  诉求填报
    // 1029    诉求办理
    // 1029    诉求监管
    // public  通知新闻
    
    
    //网络请求判断加载哪些选项卡
    
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
    
    NSDictionary * dic4=@{@"title":@"诉求监管",
                          @"image":@"main_menu_5",
                          @"class":@"ApplySuperviseVC"};
    
    NSDictionary * dic5=@{@"title":@"通知新闻",
                          @"image":@"main_menu_6",
                          @"class":@"ReportMessageVC"};
    
    [self.dataSouceArrs addObject:dic0];
    [self.dataSouceArrs addObject:dic1];
    [self.dataSouceArrs addObject:dic2];
    [self.dataSouceArrs addObject:dic3];
    [self.dataSouceArrs addObject:dic4];
    [self.dataSouceArrs addObject:dic5];
    
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight; //让uiscrollView的尺寸总是保持和父视图一致。
    [self.view addSubview:scrollView];
    
    _rootLayout = [MyLinearLayout linearLayoutWithOrientation:MyLayoutViewOrientation_Vert];
    _rootLayout.gravity = MyMarginGravity_Horz_Fill;  //设置垂直线性布局的水平填充值表明布局视图里面的所有子视图的宽度都和布局视图相等。
    
    _rootLayout.widthDime.equalTo(scrollView.widthDime);
    _rootLayout.wrapContentHeight = YES; //布局宽度和父视图一致，高度则由内容包裹。这是实现将布局视图加入滚动条视图并垂直滚动的标准方法。
    [scrollView addSubview:_rootLayout];
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_banner"]];
    //    [imageView sizeToFit];
    imageView.myHeight=MYDIMESCALEW(200);
    
    [_rootLayout addSubview:imageView];
    
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

#pragma mark -- Layout Construction


//创建单元格容器布局视图，并指定每行的数量。
-(MyFlowLayout*)createCellContainerLayout:(NSInteger)arrangedCount
{
    MyFlowLayout *containerLayout = [MyFlowLayout flowLayoutWithOrientation:MyLayoutViewOrientation_Vert arrangedCount:arrangedCount];
    containerLayout.wrapContentHeight = YES;
    containerLayout.averageArrange = YES; //平均分配里面每个子视图的宽度或者拉伸子视图的宽度以便填充满整个布局。
    containerLayout.subviewHorzMargin = 1;
    containerLayout.subviewVertMargin = 1;
    containerLayout.padding = UIEdgeInsetsMake(0, 5, 5, 5);
    
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



#pragma mark -- HandleMethod

-(void)handleCellLayoutTap:(UIView*)sender
{
    NSInteger supplementaryIndex = sender.tag / sBaseTag;
    //    NSInteger cellIndex = sender.tag % sBaseTag;
    NSString * ClassStr=[self.dataSouceArrs[supplementaryIndex]objectForKey:@"class"];
    UIViewController * clazz = [[NSClassFromString(ClassStr) alloc]init];
    clazz.title=[self.dataSouceArrs[supplementaryIndex] objectForKey:@"title"];
    clazz.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController pushVC: clazz animated:YES];
    NSLog(@"%@",ClassStr);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataSouceArrs{
    
    if (_dataSouceArrs==nil) {
        _dataSouceArrs=[NSMutableArray array];
    }
    return _dataSouceArrs;
}
@end
