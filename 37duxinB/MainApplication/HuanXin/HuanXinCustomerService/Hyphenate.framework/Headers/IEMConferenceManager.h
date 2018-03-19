/*!
 *  \~chinese
 *  @header IEMConferenceManager.h
 *  @abstract 此协议定义了多人实时音频/视频通话相关操作
 *  @author Hyphenate
 *  @version 3.00
 *
 *  \~english
 *  @header IEMConferenceManager.h
 *  @abstract This protocol defines a multiplayer real-time audio / video call related operation
 *  @author Hyphenate
 *  @version 3.00
 */

#ifndef IEMConferenceManager_h
#define IEMConferenceManager_h

#import <Foundation/Foundation.h>

#import "EMCallConference.h"
#import "EMCallLocalView.h"
#import "EMCallRemoteView.h"
#import "EMConferenceManagerDelegate.h"

@class EMError;

/*!
 *  \~chinese
 *  多人实时音频/视频通话相关操作
 *
 *  \~english
 *  Multi-user real-time audio / video call related operations
 */
@protocol IEMConferenceManager <NSObject>

@optional

#pragma mark - Delegate

/*!
 *  \~chinese
 *  添加回调代理
 *
 *  @param aDelegate  要添加的代理
 *  @param aQueue     执行代理方法的队列
 *
 *  \~english
 *  Add delegate
 *
 *  @param aDelegate  Delegate
 *  @param aQueue     The queue of call delegate method
 */
- (void)addDelegate:(id<EMConferenceManagerDelegate>)aDelegate
      delegateQueue:(dispatch_queue_t)aQueue;

/*!
 *  \~chinese
 *  移除回调代理
 *
 *  @param aDelegate  要移除的代理
 *
 *  \~english
 *  Remove delegate
 *
 *  @param aDelegate  Delegate
 */
- (void)removeDelegate:(id<EMConferenceManagerDelegate>)aDelegate;

#pragma mark - Conference

/*!
 *  \~chinese
 *  创建并加入会议
 *
 *  @param aPassword         会议密码
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Create and join a conference
 *
 *  @param aPassword         The password of the conference
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)createAndJoinConferenceWithPassword:(NSString *)aPassword
                                 completion:(void (^)(EMCallConference *aCall, NSString *aPassword, EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  加入已有会议
 *
 *  @param aConfId           会议ID(EMCallConference.confId)
 *  @param aPassword         会议密码
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Join a conference
 *
 *  @param aConfId           Conference ID (EMCallConference.confId)
 *  @param aPassword         The password of the conference
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)joinConferenceWithConfId:(NSString *)aConfId
                        password:(NSString *)aPassword
                      completion:(void (^)(EMCallConference *aCall, EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  邀请人加入会议
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aUserName         被邀请人的环信ID
 *  @param aPassword         会议密码
 *  @param aExt              扩展信息
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Invite user join the conference
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aUserName         The Hyphenate ID of the invited user
 *  @param aPassword         The password of the conference
 *  @param aExt              Extended Information
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)inviteUserToJoinConference:(EMCallConference *)aCall
                          userName:(NSString *)aUserName
                          password:(NSString *)aPassword
                               ext:(NSString *)aExt
                             error:(EMError **)pError;

/*!
 *  \~chinese
 *  上传本地摄像头的数据流
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aStreamParam      数据流的配置项
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Publish the data stream of the local camera
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aStreamParam      The config of stream
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)publishConference:(EMCallConference *)aCall
              streamParam:(EMStreamParam *)aStreamParam
               completion:(void (^)(NSString *aPubStreamId, EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  取消上传本地摄像头的数据流
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aStreamId         数据流ID（在[IEMConferenceManager publishConference:pubConfig:completion:]返回）
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Cancel the publish of the local camera's data stream
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aStreamId         Stream id (in [IEMConferenceManager publishConference:pubConfig:completion:] return)
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)unpublishConference:(EMCallConference *)aCall
                   streamId:(NSString *)aStreamId
                 completion:(void (^)(EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  订阅其他人的数据流
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aStreamId         数据流ID (在[EMConferenceManagerDelegate streamDidUpdate:addStream]中返回)
 *  @param aRemoteView       视频显示页面
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Subscribe to other user`s data streams
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aStreamId         Stream id (in [EMConferenceManagerDelegate streamDidUpdate:addStream] return )
 *  @param aRemoteView       Video display view
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)subscribeConference:(EMCallConference *)aCall
                   streamId:(NSString *)aStreamId
            remoteVideoView:(EMCallRemoteView *)aRemoteView
                 completion:(void (^)(EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  取消订阅的数据流
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aStreamId         数据流ID
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Unsubscribe data stream
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aStreamId         Stream id
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)unsubscribeConference:(EMCallConference *)aCall
                     streamId:(NSString *)aStreamId
                   completion:(void (^)(EMError *aError))aCompletionBlock;

/*!
 *  \~chinese
 *  离开会议（创建者可以离开，最后一个人离开，会议销毁）
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aCompletionBlock  完成的回调
 *
 *  \~english
 *  Leave the conference (the creator can leave, the last person to leave, the conference is destroyed)
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aCompletionBlock  The callback block of completion
 */
- (void)leaveConference:(EMCallConference *)aCall
             completion:(void (^)(EMError *aError))aCompletionBlock;


/*!
 *  \~chinese
 *  切换前后摄像头
 *
 *  @param aCall             会议实例（自己创建的无效）
 *
 *  \~english
 *  Switch the camera before and after
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 */
- (void)updateConferenceWithSwitchCamera:(EMCallConference *)aCall;

/*!
 *  \~chinese
 *  设置是否静音
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aIsMute           是否静音
 *
 *  \~english
 *  Set whether to mute
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aIsMute           Is mute
 */
- (void)updateConference:(EMCallConference *)aCall
                  isMute:(BOOL)aIsMute;

/*!
 *  \~chinese
 *  设置视频是否可用
 *
 *  @param aCall             会议实例（自己创建的无效）
 *  @param aEnableVideo      视频是否可用
 *
 *  \~english
 *  Set whether the video is available
 *
 *  @param aCall             EMConference instance (invalid by yourself)
 *  @param aEnableVideo      Whether the video is available
 */
- (void)updateConference:(EMCallConference *)aCall
             enableVideo:(BOOL)aEnableVideo;


@end


#endif /* IEMConferenceManager_h */
