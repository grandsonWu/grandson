//
//  NoteViewController.m
//  LoveBird
//
//  Created by User on 2016/11/29.
//  Copyright © 2016年 yu hasing. All rights reserved.
//
#import "SecondNoteViewController.h"
#import "NoteViewController.h"
#import "Note.h"
#import "CoreDataHelper.h"
#define kColorBarTint   [UIColor colorWithRed:170/255.0 green:60/255.0 blue:120/255.0 alpha:1.0]
@interface NoteViewController ()<UITableViewDelegate,UITableViewDataSource,SecondNoteViewControllerDelegate,UITextFieldDelegate>{
    NSMutableArray *notes;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //set NavigationBar 背景颜色&title 颜色
    [self.navigationController.navigationBar setBarTintColor:kColorBarTint];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
  
//    [self.tabBarController.tabBarItem setBadgeColor:kColorBarTint];
   

}


-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing: editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        notes = [NSMutableArray array];
        //   做查詢動作從coredata中把資料查出
        
        NSManagedObjectContext * context =[CoreDataHelper sharedInstance].managedObjectContext;             //查詢會用到NSFetchRequest
        NSFetchRequest* request =[[NSFetchRequest alloc]initWithEntityName:@"Note"];                               //查詢Entity 的name
        NSSortDescriptor *timesort = [NSSortDescriptor sortDescriptorWithKey:@"updataTime" ascending:NO ];// entity裡排序  設asconding為：ＮＯ ＝由小到大
        [request setSortDescriptors:@[timesort]]; //執行sort 他可以接受request機制
        NSError *error = nil;//  定義一個error 來攔截執行重中是否有問題
        NSArray*results=[context executeFetchRequest:request error:&error]; //執行查詢機制 結果是個array
        if (error) {
            NSLog(@"error! %@",error);
        }else{
            [notes addObjectsFromArray:results];  //如果執行都沒有問題再把results 加到 Ａrray
        }
    }
    return self;
}

- (IBAction)add:(id)sender {
    NSManagedObjectContext * context =[CoreDataHelper sharedInstance].managedObjectContext; //NSMangedObjectcontext 是物件
    Note*note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:context];  //在context 新增Note物件
    
    note.content =[NSString stringWithFormat:@"請寫下.... %ld",notes.count];
    note.updataTime=[NSDate date];//  取得目前時間
    [notes addObject:note];
    [context save:nil]; // 一旦save 資料就會放入coredata裡面

    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:notes.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - UITableViewDataSource    
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return notes.count;
    };




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"basic" forIndexPath:indexPath];
    Note * note =[notes objectAtIndex:indexPath.row];
    cell.showsReorderControl= YES;
    cell.imageView.image=[note profileImage];
    cell.textLabel.text=note.content;
       return cell;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    Note * note = notes[sourceIndexPath.row];//使用者點到哪筆資料
    [notes removeObjectAtIndex:sourceIndexPath.row];//在陣列裡無法移動必須先移除
    [notes insertObject:note atIndex:destinationIndexPath.row];//在新增
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];//從source 移到 destinationindexPath
    
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle==UITableViewCellEditingStyleDelete) {
        [notes removeObjectAtIndex:indexPath.row];
        [tableView  deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondNoteViewController *noteviewcontroller=[self.storyboard instantiateViewControllerWithIdentifier:@"noteviewcontroller"];
    Note *note =notes[tableView.indexPathForSelectedRow.row];
    noteviewcontroller.currentNote = note;
    noteviewcontroller.delegate = self;
    //以上為不用拉線也可以連接viewcontroller的方法
    
    [self.navigationController pushViewController:noteviewcontroller animated:YES];//會將下一層的view放上來這一層檢視
}

#pragma mark - SecondNoteViewControllerDelegate

- (void)secondNoteViewControllerReloadData{
    [self.tableView reloadData];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

//#pragma mark - prepareForSegue
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
//    
//    if( [segue.identifier isEqualToString:@"detail"]){
//        SecondNoteViewController *secondNoteController = segue.destinationViewController;
//        secondNoteController.delegate = self;
//    }
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
