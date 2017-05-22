//
//  ViewController.m
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import "ViewController.h"
#import "IMIBreadCrumbNavigationBar.h"
#import "IMIBreadCrumbNode.h"

@interface ViewController () <IMIBreadCrumbNavigationBarDelegate>

{
    IMIBreadCrumbNavigationBar *breadCrumbBar;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    IMIBreadCrumbNode *node = [IMIBreadCrumbNode nodeWithTitle:@"Category" andIsRootNode:YES];
    _textLabel.text = node.nodeTitle;
    breadCrumbBar = [[IMIBreadCrumbNavigationBar alloc] initWithFrame:CGRectMake(0, 50, 700, 40) andRootNode:node];
    [breadCrumbBar setDelegate:self];
    
    [self.view addSubview:breadCrumbBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)pushNodeButtonAction:(id)sender {
    
    NSArray *tempArray = @[@"Sub-Category",@"Product",@"Size",@"Add-On",@"Dip",@"Personalize"];
    
    int index = arc4random()%[tempArray count];
    
    IMIBreadCrumbNode *node = [IMIBreadCrumbNode nodeWithTitle:tempArray[index] andIsRootNode:NO];
    [breadCrumbBar setCurrentNode:node];
}

- (IBAction)popNodeButtonAction:(id)sender {
    [breadCrumbBar popNode];
}
#pragma mark - IMIBreadCrumbNavigationBarDelegate

-(void)navigationBarDidSelectBackButton:(id)bar{
    
    [breadCrumbBar popNode];
    
}

-(void)navigationBar:(id)bar didSelectNode:(IMIBreadCrumbNode *)node{
    _textLabel.text = node.nodeTitle;
    NSLog(@"Node Selected: %@",node.nodeTitle);
}

-(void)navigationBar:(id)bar didPushNode:(IMIBreadCrumbNode *)node {
    
    NSLog(@"Node Added: %@",node.nodeTitle);
    _textLabel.text = node.nodeTitle;
}
-(void)navigationBar:(id)bar didPopNode:(IMIBreadCrumbNode *)node{
    NSLog(@"Node Removed");
    _textLabel.text = node.nodeTitle;
}
@end
