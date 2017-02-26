//
//  QAViewController.m
//  LoveBird
//
//  Created by User on 2017/1/11.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "QAViewController.h"
#import "AFNetworking.h"
#define kColorBarTint   [UIColor colorWithRed:50/255.0 green:160/255.0 blue:200/255.0  alpha:0.9]
@interface QAViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray *json;
}

@property (weak, nonatomic) IBOutlet UITableView *qaView;

@end

@implementation QAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    json=[NSMutableArray array];
    self.qaView.dataSource=self;
    self.qaView.delegate=self;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:@"http://cloud.culture.tw/frontsite/trans/SearchShowAction.do?method=doFindTypeJ&category=8" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        //progress  進度回條   response 響應信息
        json = responseObject;  //響應本體訊息
        [self.qaView reloadData];
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error :%@",error);
    }];
    
    
    [self.navigationController.navigationBar setBarTintColor:kColorBarTint ];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark -table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return json.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell =[tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    //經由dequeueReusableCellWithIdentifier:詢問是否已經為建立過的Cell，若是回傳值為NUUL的話，則建立一個UITableViewCell，並賦予其名稱(initWithStyle:reuseIdentifier:)，如此當下次存取時則不會重新建立了!!

    cell.textLabel.text= [[json objectAtIndex:indexPath.row]objectForKey:@"title"];
    return cell;
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
