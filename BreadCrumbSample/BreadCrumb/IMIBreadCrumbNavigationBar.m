//
//  IMIBreadCrumbNavigationBar.m
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import "IMIBreadCrumbNavigationBar.h"
#import "IMIBreadCrumbNode.h"

@interface IMIBreadCrumbNavigationBar ()
{
    
}

@property (nonatomic , strong) NSMutableArray *nodes;
@property (nonatomic , strong) IMIBreadCrumbNode *head;
@property (nonatomic , strong) IMIBreadCrumbNode *tail;

-(void)pushNode:(IMIBreadCrumbNode *)node;


@end
@implementation IMIBreadCrumbNavigationBar

@synthesize head , tail , nodes;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        nodes = [NSMutableArray new];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andRootNode:(IMIBreadCrumbNode *)rootNode{
    
    self = [self initWithFrame:frame];
    
    // Adding Back Button
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setFrame:CGRectMake(0, 0, 60, 40)];
    [backButton setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:29.0/255.0 blue:56.0/255 alpha:1.0]];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.5]];
    [backButton.layer setCornerRadius:2.0];
    
    [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:backButton];
    
    self.head = rootNode;
    self.tail = rootNode;
    [nodes addObject:rootNode];
    
    CGRect tempFrame = rootNode.frame;
    tempFrame.origin.x = CGRectGetMaxX(backButton.frame)+10;
    rootNode.frame = tempFrame;
    
    [rootNode addTarget:self action:@selector(breadCrumbSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    [rootNode setIsTopNode:YES];
    [self addSubview:head];
    
    return self;
}

-(void)backButtonAction:(id)sender{
    
    if([_delegate respondsToSelector:@selector(navigationBarDidSelectBackButton:)]){
        [_delegate navigationBarDidSelectBackButton:self];
    }
}

-(IMIBreadCrumbNode *)rootNode{
    return self.head;
}
-(IMIBreadCrumbNode *)topNode{
    return self.tail;
}

-(void)setCurrentNode:(IMIBreadCrumbNode *)node{
    
    // Check if already exists with this name
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.nodeTitle == %@",node.nodeTitle];
    
    NSArray *filteredArray = [nodes filteredArrayUsingPredicate:predicate];
    
    if([filteredArray count] > 0){
        
        IMIBreadCrumbNode *existingNode = filteredArray[0];
        
        NSUInteger index = [nodes indexOfObject:existingNode];
        
        NSMutableArray *temArray = [NSMutableArray new];
        [temArray addObjectsFromArray:nodes];
        
        for(NSUInteger i = [nodes count]-1; i >= (index + 1); i--){
            [self popNode];
        }
        
        
        [existingNode setIsTopNode:YES];
    }
    else{
        [self pushNode:node];
        [node addTarget:self action:@selector(breadCrumbSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

-(void)pushNode:(IMIBreadCrumbNode *)node{
    
    CGFloat maxX = CGRectGetMaxX(self.tail.frame);
    CGRect frame = node.frame;
    // frame.origin.x = maxX+3;
    frame.origin.x = maxX-15;
    node.frame = frame;
    [self addSubview:node];
    
    IMIBreadCrumbNode *previousTopNode = [nodes lastObject];
    [previousTopNode setIsTopNode:NO];
    
    [node setIsTopNode:YES];
    
    
    [nodes addObject:node];
    
    [self sendSubviewToBack:node];
    self.tail = node;
    
    if([_delegate respondsToSelector:@selector(navigationBar:didPushNode:)]){
        [_delegate navigationBar:self didPushNode:node];
    }
}
-(void)popNode{
    
    if([nodes count] > 1){
        
        IMIBreadCrumbNode *topObject = [nodes lastObject];
        [nodes removeObject:topObject];
        [topObject removeFromSuperview];
        
        topObject = [nodes lastObject];
        
        [self sendSubviewToBack:topObject];
        
        [topObject setIsTopNode:YES];
        self.tail = topObject;
        
        if([_delegate respondsToSelector:@selector(navigationBar:didPopNode:)]){
            [_delegate navigationBar:self didPopNode:topObject];
        }
    }
}
-(void)breadCrumbSelected:(id)sender{
    
    IMIBreadCrumbNode *selectedNode = (IMIBreadCrumbNode *)sender;
    [self setCurrentNode:selectedNode];
    
    if([_delegate respondsToSelector:@selector(navigationBar:didSelectNode:)]){
        [_delegate navigationBar:self didSelectNode:selectedNode];
    }
}

@end
