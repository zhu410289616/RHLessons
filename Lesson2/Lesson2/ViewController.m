//
//  ViewController.m
//  Lesson2
//
//  Created by zhuruhong on 16/7/14.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

//http://www.cnblogs.com/SDJL/archive/2008/08/22/1274312.html

#import "ViewController.h"

static NSInteger max_n = 100;//程序支持的最多金矿数
static NSInteger max_people = 10000;//程序支持的最多人数

@interface ViewController ()

/** 金矿数 */
@property (nonatomic, assign) NSInteger n;
/** 可以用于挖金子的人数 */
@property (nonatomic, assign) NSInteger peopleTotal;
/** 每座金矿需要的人数 */
@property (nonatomic, strong) NSMutableArray *peopleNeed;
/** 每座金矿能够挖出来的金子数 */
@property (nonatomic, strong) NSMutableArray *gold;
/** maxGold[i][j]保存了i个人挖前j个金矿能够得到的最大金子数，等于-1时表示未知 */
@property (nonatomic, strong) NSMutableArray *maxGold;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //初始化数据
    [self createData];
    //输出给定peopleTotal个人和n个金矿能够获得的最大金子数，再次提醒编号从0开始，所以最后一个金矿编号为n-1
    NSInteger getGold = [self getMaxGoldWithPeople:_peopleTotal mineNum:_n - 1];
    NSLog(@"可以用于挖金子的人数: %ld, 金矿数: %ld", _peopleTotal, _n);
    NSLog(@"_peopleNeed: %@", _peopleNeed);
    NSLog(@"_gold: %@", _gold);
    NSLog(@"getGold: %ld", getGold);
    
}

/** 初始化数据 */
- (void)createData
{
    _n = 10;// max_n;
    _peopleTotal = 6;//max_people;
    _peopleNeed = [[NSMutableArray alloc] init];
    _gold = [[NSMutableArray alloc] init];
    
    for (NSInteger i=0; i<_n; i++) {
        NSInteger tempPeopleNeed = arc4random() % 5;//256;
        NSInteger tempGold = arc4random() % 5;//256;
        
        [_peopleNeed addObject:@(tempPeopleNeed + 1)];
        [_gold addObject:@(tempGold + 1)];
    }
    
    _maxGold = [[NSMutableArray alloc] init];
    for (NSInteger i=0; i<=_peopleTotal; i++) {
        NSMutableArray *peopleArray = [[NSMutableArray alloc] init];
        for (NSInteger j=0; j<_n; j++) {
            [peopleArray addObject:@(-1)];
        }
        [_maxGold addObject:peopleArray];
    }
}

/** 获得在仅有people个人和前mineNum个金矿时能够得到的最大金子数，注意“前多少个”也是从0开始编号的 */
- (NSInteger)getMaxGoldWithPeople:(NSInteger)people mineNum:(NSInteger)mineNum
{
    //申明返回的最大金子数
    NSInteger retMaxGold;
    
    //如果这个问题曾经计算过  [对应动态规划中的“做备忘录”]
    if ([_maxGold[people][mineNum] integerValue] != -1) {
        //获得保存起来的值
        retMaxGold = [_maxGold[people][mineNum] integerValue];
    }
    else if (mineNum == 0)//如果仅有一个金矿时 [对应动态规划中的“边界”]
    {
        //当给出的人数足够开采这座金矿
        if (people >= [_peopleNeed[mineNum] integerValue]) {
            //得到的最大值就是这座金矿的金子数
            retMaxGold = [_gold[mineNum] integerValue];
        }
        else//否则这唯一的一座金矿也不能开采
        {
            //得到的最大值为0个金子
            retMaxGold = 0;
        }
    }
    else if (people >= [_peopleNeed[mineNum] integerValue])//如果给出的人够开采这座金矿 [对应动态规划中的“最优子结构”]
    {
        //考虑开采与不开采两种情况，取最大值
        NSInteger a = [self getMaxGoldWithPeople:people - [_peopleNeed[mineNum] integerValue] mineNum:mineNum -1];
        NSInteger b = [self getMaxGoldWithPeople:people mineNum:mineNum -1];
        retMaxGold = fmax(a + [_gold[mineNum] integerValue], b);
    }
    else//否则给出的人不够开采这座金矿 [对应动态规划中的“最优子结构”]
    {
        //仅考虑不开采的情况
        retMaxGold  = [self getMaxGoldWithPeople:people mineNum:mineNum -1];
    }
    
    //做备忘录
    _maxGold[people][mineNum] = @(retMaxGold);
    return retMaxGold;
}

@end
