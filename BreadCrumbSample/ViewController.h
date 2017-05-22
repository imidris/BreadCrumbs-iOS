//
//  ViewController.h
//  BreadCrumbSample
//
//  Created by Muhammad Idris on 12/23/15.
//  Copyright © 2015 ABC-Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
- (IBAction)pushNodeButtonAction:(id)sender;
- (IBAction)popNodeButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

