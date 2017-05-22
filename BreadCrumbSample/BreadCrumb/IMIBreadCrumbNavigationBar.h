//
//  IMIBreadCrumbNavigationBar.h
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IMIBreadCrumbNode;

@protocol IMIBreadCrumbNavigationBarDelegate <NSObject>

@optional
-(void)navigationBar:(id)bar didSelectNode:(IMIBreadCrumbNode *)node;
-(void)navigationBarDidSelectBackButton:(id)bar;

-(void)navigationBar:(id)bar didPushNode:(IMIBreadCrumbNode *)node;
-(void)navigationBar:(id)bar didPopNode:(IMIBreadCrumbNode *)node;

@end

@interface IMIBreadCrumbNavigationBar : UIView
{
    
}
@property (nonatomic , assign) id<IMIBreadCrumbNavigationBarDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame andRootNode:(IMIBreadCrumbNode *)rootNode;

-(void)setCurrentNode:(IMIBreadCrumbNode *)node;
-(void)pushNode:(IMIBreadCrumbNode *)node;
-(void)popNode;

-(IMIBreadCrumbNode *)rootNode;
-(IMIBreadCrumbNode *)topNode;


@end
