# MCScrollView
The direction of the integration of a variety of Scrollview
集成多种循环方向的ScrollView

Support network download and local loading images, network download you need to import the SDWebimage library
同时支持网络下载与本地加载图片,网络下载需要导入SDWebimage库

Create the MC object, choosing the way of circulation, CycleDirectionLandscape for horizontal circulation, CycleDirectionPortait for vertical circulation, arr is image array, the array can be UIImage objects or nsstrings object

创建MC对象选择循环的方式,CycleDirectionLandscape为水平循环,CycleDirectionPortait为垂直循环,arr为图片数组,数组内可以为UIImage对象或者NSString对象

MCScrollView *MC=[[MCScrollView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) cycleDirection:CycleDirectionLandscape pictures:arr isNetworkLink:NO];

[self.view addSubview:MC];

MCScrollView can support landscape or portrait, can dynamically calculate the height of images, the support load long of height figure
MCScrollView 可以支持横屏和竖屏的状态,动态计算图片的长宽高,支持加载长图
