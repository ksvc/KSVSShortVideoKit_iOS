//
//  KSVSErrorCodeDefines.h
//  KSVSSdk
//
//  Created by devcdl on 2017/11/29.
//  Copyright © 2017年 Kingsoft. All rights reserved.
//

#ifndef KSVSErrorCodeDefines_h
#define KSVSErrorCodeDefines_h

/**
 * http code 400/500
 * ksvssdk服务被拒绝或服务异常
 */
static NSInteger const KSVS_ERROR = -260001;

/**
 * http code 500
 * ksvssdk服务内部错误
 */
static NSInteger const KSVS_SERVER_ERROR = -260002;

/**
 * http code 401/402/403/404
 * ksvssdk服务权限禁止
 */
static NSInteger const KSVS_ACCESS_DENIED = -260003;

/**
 * http code 400
 * 无效参数
 */
static NSInteger const KSVS_INVALID_PARAMETRES = -260004;

/**
 * http code 400
 * 不支持（暂无）
 */
static NSInteger const KSVS_NOT_SUPPORTED = -260005;

/**
 * http code 400
 * 参数不匹配
 */
static NSInteger const KSVS_PARAMETRE_NOT_MATCH = -260006;

/**
 * http code 400
 * 无效的Token (鉴权 特有)
 */
static NSInteger const KSVS_INVALID_TOKEN = -260007;

/**
 * http code 400
 * Token 不匹配 (鉴权 特有)
 */
static NSInteger const KSVS_TOKEN_NOT_MATCH = -260008;

/**
 * http code 400
 * 服务过期
 */
static NSInteger const KSVS_SERVICE_TIMEOUT = -260009;

/**
 * http code 400
 * 服务异常
 */
static NSInteger const KSVS_SERVICE_EXCEPTION = -260010;

/**
 * http code 400
 * 无效的模块
 */
static NSInteger const KSVS_INVALID_MODULE = -260011;

/**
 * http code 400
 * 无效的Bucket（暂无
 */
static NSInteger const KSVS_INVALID_BUCKET = -260012;

/**
 * http code 400
 * 签名过期
 */
static NSInteger const KSVS_SIGNATURE_EXPIRED = -260013;

/**
 * http code 400
 * 签名不匹配
 */
static NSInteger const KSVS_SIGNATURE_NOT_MATCH = -260014;

/**
 * http code 400
 * 不支持的文件权限，目前信息合并到ParameterNotMatch
 */
static NSInteger const KSVS_NOT_SUPPORTED_FILE_ACL = -260015;

/**
 * http code 400
 * 无效的文件或文件不支持
 */
static NSInteger const KSVS_INVALID_FILE = -260016;

/**
 * http code 400
 * 无效的服务配置
 */
static NSInteger const KSVS_INVALID_CONFIG = -260017;

/**
 * http code 400
 * 推荐服务尚未配置或配置有误
 */
static NSInteger const KSVS_RECSERVEr_UNCONFIGURED = -260018;

/**
 * http code 401
 * APP用户未登陆或APP SERVER验证失败
 */
static NSInteger const KSVS_NOT_LOGIN = -260019;

/*******  自定义code  ********/
/**
 * Token 为空 (鉴权 特有)
 */
static NSInteger const KSVS_TOKEN_NULL = -360001;

/**
 * bundleId 为空 (鉴权 特有)
 */
static NSInteger const KSVS_BUNDLEID_NULL = -360002;

/**
 * 上传视频的地址（localVideoPath）为空、格式错误（非.mp4结尾）
 */
static NSInteger const KSVS_UPLOAD_VIDEOPATH_INVALID = -370001;

/******** 展示文案 ********/
static NSString * const kSVSNoNetworkString = @"当前网络不可用";
static NSString * const kSelectNoneVideoString = @"还未选中任何视频";
static NSString * const kReachedMaxRecordTimeString = @"已达到最大录制时长";
static NSString * const kAppUserNotLoginString = @"用户未登录";

#endif /* KSVSErrorCodeDefines_h */
