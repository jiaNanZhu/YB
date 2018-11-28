//
//  RanchConst.m
//  Ranch
//
//  Created by GZP on 2018/1/25.
//  Copyright © 2018年 gzp_macbook. All rights reserved.
//

NSString *const CMProduceDetail = @"/api/v2/good/good-show";
NSString *const XiLieRightList = @"/api/v2/good/series-list";
NSString *const MallAllCategory = @"/api/v2/good/class";
NSString *const HOST = @"http://yb.dashuibei.com";


//============= 个人信息 ====================//
//uid
NSString *const User_id = @"user_id";
//mobile
NSString *const User_mobile = @"user_mobile";
//token
NSString *const User_token = @"d1736256d1200e6f5268eda40005f5701019cc41";



NSString *const Green_Color = @"47b546";
NSString *const Nav_Color = @"333333";
NSString *const Back_Color = @"edecea";
NSString *const Gray_Color = @"ededed";
NSString *const Yellow_Color = @"ffb600";
NSString *const Blue_Color = @"0386FF";


//============= 网络接口====================

#pragma mark 个人中心
//获取用户基本信息
NSString *const UserCenter_getinfo = @"/index.php/Home/UserCenter/getinfo";
//n
NSString *const User_GetInfo = @"/index.php/Home/UserCenter/get_userinfo";

#pragma mark 登录/注册
//登录
NSString *const Login = @"/index.php/Home/User/loginbypwd";

//验证码登录
NSString *const Loginbycode = @"/index.php/Home/User/loginbycode";

//注册
NSString *const Regist = @"/index.php/Home/User/register";
//重置密码
NSString *const Resetpwd = @"/index.php/Home/User/resetpwd";
//获取验证码
NSString *const GetVerifyCode = @"verifycodes";

//基本信息设置
NSString *const UserCenter_setinfo = @"/index.php/Home/UserCenter/setinfo";

//修改绑定手机号
NSString *const UserCenter_setmobile = @"/index.php/Home/UserCenter/setmobile";

//获取任务列表
NSString *const Get_tasklist = @"/index.php/Home/CommonTask/get_tasklist";

//获取任务详情
NSString *const Get_taskdetail = @"/index.php/Home/CommonTask/get_taskdetail";

//图片上传
NSString *const UserCenter_imgupload = @"/index.php/Home/UserCenter/imgupload";

//任务详情——申请列表
NSString *const Get_applylist = @"/index.php/Home/CommonTask/get_applylist";

//任务详情——留言列表
NSString *const Get_boardlist = @"/index.php/Home/CommonTask/get_boardlist";

//任务详情——发表留言
NSString *const Add_board = @"/index.php/Home/Board/add_board";

//任务收藏操作
NSString *const Add_collect = @"/index.php/Home/Handle/add_collect";

//任务详情_用户报名
NSString *const Add_apply = @"/index.php/Home/Apply/add_apply";

//任务发布图片上传接口
NSString *const ImageUpload = @"/index.php/Home/Task/imgupload";

//任务详情——报名人操作
NSString *const Change_apply = @"/index.php/Home/Apply/change_apply";

//已完成任务提交
NSString *const Tijiao = @"/index.php/Home/MyTask/tijiao";

//我发布的任务审核
NSString *const Shenhe = @"/index.php/Home/MyTask/shenhe";

//用户评价接口
NSString *const Pingjia = @"/index.php/Home/MyTask/pingjia";

//接受任务统计—总数
NSString *const receiveTotal = @"/index.php/Home/MyTask/receive_sum_total";

//接受任务统计—列表
NSString *const receiveSumList = @"/index.php/Home/MyTask/receive_sum_list";

//获取首页banner
NSString *const getBanner = @"/index.php/Home/Index/get_banner";

//首页热门帖子
NSString *const hotPost = @"/index.php/Home/Index/hot_post";

//首页任务列表
NSString *const indexTask = @"/index.php/Home/Index/index_task";

//获取城市列表
NSString *const getCity = @"/index.php/Home/Index/get_city";

//首页搜索
NSString *const getSearch = @"/index.php/Home/Index/get_search";

//首页搜索热门
NSString *const getHotSearch = @"/index.php/Home/Index/get_hotsearch";

//支付接口
NSString *const toPay = @"/index.php/Home/Pay/topay";

//我的价值
NSString *const getWallet = @"/index.php/Home/MyWallet/get_wallet";

//零钱明细
NSString *const getMingXi = @"/index.php/Home/MyWallet/get_mingxi";

//投诉电话
NSString *const hotLine = @"18135697075";

//我发布的角标
NSString *const faBuNum = @"/index.php/Home/MyTask/fabu_num";

//我接受的角标
NSString *const jieShouNum = @"/index.php/Home/MyTask/jieshou_num";

//获取验证码
NSString *const sendsms = @"/index.php/Home/User/sendsms";

/*ZJN上面写👆~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

//酒馆大厅-列表
NSString *const CommonDrunkery_post_list = @"/index.php/Home/CommonDrunkery/post_list";

//酒馆详情-发帖
NSString *const CommonDrunkery_post_add = @"/index.php/Home/Drunkery/post_add";

//我发布的任务列表
NSString *const UserCenter_MyTask_publish_lis = @"/index.php/Home/MyTask/publish_list";

//任务发布接口
NSString *const Home_Task_addtask = @"/index.php/Home/Task/addtask";

//发布任务统计总数
NSString *const UserCenter_MyTask_publish_sum_total = @"/index.php/Home/MyTask/publish_sum_total";

//发布任务统计列表
NSString *const UserCenter_MyTask_publish_sum_list = @"/index.php/Home/MyTask/publish_sum_list";

//我接受的任务列表
NSString *const UserCenter_MyTask_receive_list = @"/index.php/Home/MyTask/receive_list";

//我收藏的任务
NSString *const UserCenter_get_collect = @"/index.php/Home/UserCenter/get_collect";

//关注的用户
NSString *const UserCenter_get_care = @"/index.php/Home/UserCenter/get_care";

//获取我的资历
NSString *const UserCenter_get_zili = @"/index.php/Home/UserCenter/get_zili";

//设置我的资历
NSString *const UserCenter_set_zili = @"/index.php/Home/UserCenter/set_zili";

//我发布的任务上架
NSString *const UserCenter_shangjia = @"/index.php/Home/MyTask/shangjia";

//我发布的任务下架
NSString *const UserCenter_xiajia = @"/index.php/Home/MyTask/xiajia";

//我发布的任务审核
NSString *const UserCenter_shenhe = @"/index.php/Home/MyTask/shenhe";

//酒馆大厅-详情
NSString *const CommonDrunkery_post_detail = @"/index.php/Home/CommonDrunkery/post_detail";

//酒馆详情-发表留言
NSString *const Drunkery_liuyan_add = @"/index.php/Home/Drunkery/liuyan_add";

//酒馆详情-回复留言
NSString *const Drunkery_huifu_add = @"/index.php/Home/Drunkery/huifu_add";

//通用单图上传
NSString *const UserCenter_singleimgup = @"/index.php/Home/UserCenter/singleimgup";

//个人实名认证提交
NSString *const UserCenter_set_renzheng = @"/index.php/Home/UserCenter/set_renzheng";


//个人资料——基本信息
NSString *const UserCenter_get_userinfo = @"/index.php/Home/UserCenter/get_userinfo";


//个人资料——我的履历
NSString *const UserCenter_get_uservitae = @"/index.php/Home/UserCenter/get_uservitae";

//个人资料——我的任务
NSString *const UserCenter_get_tasksum = @"/index.php/Home/UserCenter/get_tasksum";

//关注用户
NSString *const UserCenter_add_care = @"/index.php/Home/Handle/add_care";

//私聊列表
NSString *const UserCenter_message_get = @"/index.php/Home/YbTest/message_get";


//设置私聊已读状态
NSString *const UserCenter_message_read_set = @"/index.php/Home/YbTest/read_set";


//添加私聊记录
NSString *const UserCenter_message_add = @"/index.php/Home/YbTest/message_add";



//系统消息列表
NSString *const UserCenter_notice_get = @"/index.php/Home/YbTest/notice_list";

//酒馆消息列表
NSString *const UserCenter_post_get = @"/index.php/Home/YbTest/post_message_list";


//任务消息列表
NSString *const UserCenter_task_message_get = @"/index.php/Home/YbTest/task_message_list";



//我的成就
NSString *const UserCenter_my_achieve = @"/index.php/Home/MyAchieve/my_achieve";

//消息详情
NSString *const UserCenter_message_info_get = @"/index.php/Home/YbTest/message_info_get";

//是否同意推广协议
NSString *const IsAgree = @"/index.php/Home/Promo/isagree";

//守则获取
NSString *const getContent = @"/index.php/Home/Shouze/get_content";

//修改悬赏金额
NSString *const Editprice = @"/index.php/Home/TaskFaBu/editprice";

//延期审核
NSString *const YanQi = @"/index.php/Home/TaskFaBu/yanqi";

//获取银行列表
NSString *const GetBank = @"/index.php/Home/Index/get_qmbank";

//支持省市获取
NSString *const Qmprivnce = @"/index.php/Home/Index/get_qmprivnce";

//分账方基本信息注册
NSString *const NewRegister = @"/index.php/Home/QmUser/new_register";

//退款申请
NSString *const TuiKuan = @"/index.php/Home/MyTask/tuikuan";

//根据卡号获取银行名称
NSString *const getBankName = @"/index.php/Home/Index/get_bankname";
