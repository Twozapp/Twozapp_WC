//
//  ProfileOneViewController.m
//  Twozapp
//
//  Created by Priya on 09/01/16.
//  Copyright © 2016 Priya. All rights reserved.
//

#import "ProfileOneViewController.h"
#import "OnDeck.h"
#import "SlideAlertiOS7.h"
#import "AppDelegate.h"

@interface ProfileOneViewController ()
{
    NSArray *arrTime;
    NSArray *arrMonth;
    NSString *currentYear;
}
@end

@implementation ProfileOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self appDelegate].locationManager startUpdatingLocation];
    [self performSelector:@selector(stopLocationFetching) withObject:nil afterDelay:5.0];
    self.navigationController.navigationBar.userInteractionEnabled = NO;

    //UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap)];
    //[self.view addGestureRecognizer:tap];
    
    _txtEmail.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"email"];
    [OnDeck sharedInstance].strName = _txtName.text;
    [OnDeck sharedInstance].strEmail = _txtEmail.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    currentYear = [formatter stringFromDate:[NSDate date]];
    [OnDeck sharedInstance].strBirthday = [NSString stringWithFormat:@"%@-%@-%@",_lblDay.text, _lblMonth.text,_lblYear.text];
   
     UIImage *navImage =  [[UIImage imageNamed:@"navigationbar"]
     resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];

    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundImage:navImage forBarMetrics:UIBarMetricsCompact];
    
    [_rightBarButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"Segoe Print" size:20.0], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                        nil] 
                              forState:UIControlStateNormal];
    
    arrTime = @[@"12:00am - 01:00am", @"01:00am - 02:00am", @"02:00am - 03:00am", @"03:00am - 04:00am", @"04:00am - 05:00am", @"05:00am - 06:00am", @"06:00am - 07:00am", @"07:00am - 08:00am", @"08:00am - 09:00am", @"09:00am - 10:00am", @"10:00am - 11:00am", @"11:00am - 12:00pm", @"12:00pm - 01:00pm", @"01:00pm - 02:00pm", @"02:00pm - 03:00pm", @"03:00pm - 04:00pm", @"04:00pm - 05:00pm", @"05:00pm - 06:00pm", @"06:00pm - 07:00pm", @"07:00pm - 08:00pm", @"08:00pm - 09:00pm", @"09:00pm - 10:00pm", @"10:00pm - 11:00pm", @"11:00pm - 12:00am"];
    
    arrMonth = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    
    _tblday.hidden = YES;
    _tblTime.hidden = YES;
    _tblMonth.hidden = YES;
    _tblYear.hidden = YES;
    
    _tblday.layer.borderWidth = 1.0f;
    _tblday.layer.borderColor = [UIColor redColor].CGColor;
    _tblday.layer.cornerRadius = 5.0f;
    
    _tblTime.layer.borderWidth = 1.0f;
    _tblTime.layer.borderColor = [UIColor redColor].CGColor;
    _tblTime.layer.cornerRadius = 5.0f;
    
    _tblMonth.layer.borderWidth = 1.0f;
    _tblMonth.layer.borderColor = [UIColor redColor].CGColor;
    _tblMonth.layer.cornerRadius = 5.0f;
    
    _tblYear.layer.borderWidth = 1.0f;
    _tblYear.layer.borderColor = [UIColor redColor].CGColor;
    _tblYear.layer.cornerRadius = 5.0f;
    
    
    _txtEmail.layer.cornerRadius = 5.0f;
    _txtEmail.layer.borderColor = [UIColor redColor].CGColor;
    _txtEmail.layer.borderWidth = 1.0f;
    
    _txtName.layer.cornerRadius = 5.0f;
    _txtName.layer.borderColor = [UIColor redColor].CGColor;
    _txtName.layer.borderWidth = 1.0f;
    
    _txtHeight.layer.cornerRadius = 5.0f;
    _txtHeight.layer.borderColor = [UIColor redColor].CGColor;
    _txtHeight.layer.borderWidth = 1.0f;
    
    _txtWeight.layer.cornerRadius = 5.0f;
    _txtWeight.layer.borderColor = [UIColor redColor].CGColor;
    _txtWeight.layer.borderWidth = 1.0f;
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtName resignFirstResponder];
    [_txtEmail resignFirstResponder];
    [_txtWeight resignFirstResponder];
    [_txtHeight resignFirstResponder];
    
    _tblYear.hidden = YES;
    _tblTime.hidden = YES;
    _tblday.hidden = YES;
    _tblMonth.hidden = YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _txtName)
    {
        [_txtName resignFirstResponder];
    }
    
    if (textField == _txtWeight) {
        [_txtWeight resignFirstResponder];
    }
    if (textField == _txtHeight) {
        [_txtHeight resignFirstResponder];
    }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtHeight || textField == _txtWeight) {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        
    }
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if (textField == _txtHeight || textField == _txtWeight) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        
        
    }
    
    return YES;
}


- (void)keyboardDidShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-200,self.view.frame.size.width,self.view.frame.size.height)]; //here taken -20 for example i.e. your view will be scrolled to -20. change its value according to your requirement.
     } completion:nil];
    
}

-(void)keyboardDidHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
    [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
         [self.view endEditing:YES];
         } completion:nil];
}




- (IBAction)actionNext:(id)sender{
    
    if (_txtName.text.length == 0) {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter the Name"];
    }
    else if ([OnDeck sharedInstance].strGender.length == 0)
    {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please select a Gender"];
    }
    else if ([OnDeck sharedInstance].strBirthday.length == 0)
    {
      [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter the Birthday"];
    }
    else if (_lblBirthday.text.length == 0)
    {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter the Birth Time"];
    }
    else if (_txtWeight.text.length == 0)
    {
        [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter the Height"];
    }
    else if (_txtHeight.text.length == 0)
    {
       [[SlideAlertiOS7 sharedSlideAlert] showSlideAlertViewWithStatus:@"Failure" withText:@"Please enter the Weight"];
    }
    
    else
    {
    [OnDeck sharedInstance].strName = _txtName.text;
    [OnDeck sharedInstance].strEmail = _txtEmail.text;
    [OnDeck sharedInstance].strBirthday = [NSString stringWithFormat:@"%@-%@-%@",_lblDay.text, _lblMonth.text,_lblYear.text];
    [OnDeck sharedInstance].strBirthtime = _lblBirthday.text;
    [OnDeck sharedInstance].strHeight = _txtHeight.text;
    [OnDeck sharedInstance].strWeight = _txtWeight.text;
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *profileTwo = [story instantiateViewControllerWithIdentifier:@"ProfileTwoViewController"];
    [self.navigationController pushViewController:profileTwo animated:YES];
    }
}

- (IBAction)actionDay:(id)sender {
    _tblMonth.hidden = YES;
    _tblYear.hidden = YES;
    _tblTime.hidden = YES;
    _tblday.hidden = !_tblday.hidden;
    [_tblday reloadData];
    
}

- (IBAction)actionTime:(id)sender {
    _tblMonth.hidden = YES;
    _tblYear.hidden = YES;
    _tblday.hidden = YES;
    _tblTime.hidden = !_tblTime.hidden;
    
}

- (IBAction)actionMonth:(id)sender {
    _tblMonth.hidden = !_tblMonth.hidden;
    _tblYear.hidden = YES;
    _tblTime.hidden = YES;
    _tblday.hidden = YES;
    [_tblday reloadData];
}

- (IBAction)actionyear:(id)sender {
    
    _tblMonth.hidden = YES;
    _tblYear.hidden = !_tblYear.hidden;
    _tblTime.hidden = YES;
    _tblday.hidden = YES;
    [_tblday reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblTime) {
        return arrTime.count;
    }
    else if (tableView == _tblMonth)
    {
        return arrMonth.count;
    }
    else if (tableView == _tblYear)
    {
        return 100;
    }
    else
    {
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        // Set your year and month here
        [components setYear:_lblYear.text.integerValue];
        [components setMonth:[arrMonth indexOfObject:_lblMonth.text] + 1];
        
        NSDate *date = [calendar dateFromComponents:components];
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        
        NSLog(@"%d", (int)range.length);
        
        
//        NSString *strDate = [NSString stringWithFormat:@"03/%@/%@",_lblMonth.text,_lblYear.text];
//        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        [dateFormatter setDateFormat:@"dd/MMM/YYYY"];
//        NSDate *selDate = [dateFormatter dateFromString:strDate];
//        NSCalendar *c = [NSCalendar currentCalendar];
//        NSRange days = [c rangeOfUnit:NSDayCalendarUnit
//                               inUnit:NSMonthCalendarUnit
//                              forDate:selDate];
        
//        NSLog(@"days = %lu",(unsigned long)days.length);
        
        
    return (int)range.length;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblTime) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *lbl = (UILabel *)[cell viewWithTag:10];
        lbl.text = [NSString stringWithFormat:@"%@",arrTime[indexPath.row]];
        
        return cell;
    }
    else if (tableView == _tblMonth)
    {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            UILabel *lbl = (UILabel *)[cell viewWithTag:10];
            lbl.text = [NSString stringWithFormat:@"%@",arrMonth[indexPath.row]];
        
            return cell;
    }
    else if (tableView == _tblYear)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        UILabel *lbl = (UILabel *)[cell viewWithTag:10];
        lbl.text = [NSString stringWithFormat:@"%ld", currentYear.intValue - (long)indexPath.row];
        
        return cell;
    }
    else
    {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *lbl = (UILabel *)[cell viewWithTag:10];
    lbl.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _tblTime) {
        _lblBirthday.text = [NSString stringWithFormat:@"%@",arrTime[indexPath.row]];
        _tblTime.hidden = YES;
        
    }
    else if (tableView == _tblMonth){
        _lblMonth.text = [NSString stringWithFormat:@"%@",arrMonth[indexPath.row]];
        [_tblday reloadData];
        _tblMonth.hidden = YES;
        [OnDeck sharedInstance].strBirthday = [NSString stringWithFormat:@"%@-%@-%@",_lblDay.text, _lblMonth.text,_lblYear.text];
        
    }else if (tableView == _tblYear){
        _lblYear.text = [NSString stringWithFormat:@"%ld", currentYear.intValue - (long)indexPath.row];
        [_tblday reloadData];
        _tblYear.hidden = YES;
        [OnDeck sharedInstance].strBirthday = [NSString stringWithFormat:@"%@-%@-%@",_lblDay.text, _lblMonth.text,_lblYear.text];
    }
    else if (tableView == _tblday){
        _lblDay.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
        _tblday.hidden = YES;
        [OnDeck sharedInstance].strBirthday = [NSString stringWithFormat:@"%@-%@-%@",_lblDay.text, _lblMonth.text,_lblYear.text];
        
    }
}

- (IBAction)actionGMale:(id)sender {
    
    if ([_imgGMale.image isEqual:[UIImage imageNamed:@"genderrednot"]]) {
        _imgGMale.image = [UIImage imageNamed:@"genderred"];
        [OnDeck sharedInstance].strGender = @"1";
    }
    else
    {
        _imgGMale.image = [UIImage imageNamed:@"genderrednot"];
    }
    _imgGfemale.image = [UIImage imageNamed:@"genderrednot"];
}

- (IBAction)actionGFemale:(id)sender {
    if ([_imgGfemale.image isEqual:[UIImage imageNamed:@"genderrednot"]]) {
        _imgGfemale.image = [UIImage imageNamed:@"genderred"];
        [OnDeck sharedInstance].strGender = @"2";
    }
    else
    {
        _imgGfemale.image = [UIImage imageNamed:@"genderrednot"];
    }
    _imgGMale.image = [UIImage imageNamed:@"genderrednot"];
    
}

- (IBAction)actionLMale:(id)sender {
    if ([_imgLMale.image isEqual:[UIImage imageNamed:@"genderrednot"]]) {
        _imgLMale.image = [UIImage imageNamed:@"genderred"];
        [OnDeck sharedInstance].strLookingfor = @"Male";
    }
    else
    {
        _imgLMale.image = [UIImage imageNamed:@"genderrednot"];
    }
    _imgLFemale.image = [UIImage imageNamed:@"genderrednot"];
}

- (IBAction)actionLFemale:(id)sender {
    if ([_imgLFemale.image isEqual:[UIImage imageNamed:@"genderrednot"]]) {
        _imgLFemale.image = [UIImage imageNamed:@"genderred"];
        [OnDeck sharedInstance].strLookingfor = @"Female";
    }
    else
    {
        _imgLFemale.image = [UIImage imageNamed:@"genderrednot"];
    }
    
    _imgLMale.image = [UIImage imageNamed:@"genderrednot"];
}

- (AppDelegate *)appDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (void)stopLocationFetching
{
    [[self appDelegate].locationManager stopUpdatingLocation];
}

- (void)actionTap
{
    [UIView animateWithDuration:0.25
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         [self.view setFrame:CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height)];
         [self.view endEditing:YES];
     } completion:nil];
    
}

@end
