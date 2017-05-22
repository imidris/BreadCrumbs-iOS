//
//  IMIBreadCrumbNode.h
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IMIBreadCrumbNode : UIControl

@property (nonatomic ,strong) NSString *nodeTitle;

-(id)init __deprecated_enum_msg("Use nodeWithTitle: instead");
+(id)nodeWithTitle:(NSString *)titleString andIsRootNode:(BOOL)isRoot;
-(void)setIsTopNode:(BOOL)isTopNode;
-(BOOL)topNode;

@end
