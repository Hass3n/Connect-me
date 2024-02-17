abstract class SocialState{}
class SocialIntialState extends SocialState{}
class SocialloadGetuserState extends SocialState{}
class SocialGetusersucess extends SocialState{}
class SocialGetuserError extends SocialState
{
  final String error;

  SocialGetuserError(this.error);

}

class ChangeIndex extends SocialState
{

}
class SocialPickeProfileImagesucess extends SocialState{}
class SocialPickeProfileImageError extends SocialState{}
class SocialPickeCoverImagesucess extends SocialState{}
class SocialPickeCoverImageError extends SocialState{}
class SocialLoadprofileImagesucess extends SocialState{}
class SocialLoadprofileImageError extends SocialState{}
class SocialLoadCoverImagesucess extends SocialState{}
class SocialLoadCoverImageError extends SocialState{}

class SocialLoadUpdateuerData extends SocialState{}
class  SocialLoadUpdateuerDataError extends SocialState{}

class SocialChangeData extends SocialState{}

class SocialLoadPost extends SocialState{}
class  SocialLoadSucesspost extends SocialState{}
class  SocialLoaderrorpost extends SocialState{}

class  SocialLoadsucessImagepost extends SocialState{}
class  SocialLoaderrorImagepost extends SocialState{}

class SocialLoadpickpostImagesucess extends SocialState{}
class SocialLoadpickpostImageError extends SocialState{}
class SocialRemovepost extends SocialState{}
class SocialGetallpostsucess extends SocialState{}
class SocialGetAlleposterror extends SocialState{}
class SocialLikepostsucess extends SocialState{}
class SocialLikeposterror extends SocialState{}
class SocialChangeLikeIcon extends SocialState{}

class  SocialloadSucessuser extends SocialState{}
class  Socialloaderrorsuser extends SocialState{}

class  SocialSendMessageSucessState extends SocialState{}
class  SocialSendMessageErrorState extends SocialState{}
class  SocialGetMessageSucessState extends SocialState{}
class  SocialGetMessageErrorState extends SocialState{}
class  SocialSendUnreadMessageSucessState extends SocialState{}
class SocialSendUnreadMessageErrorState extends SocialState{}
class SocialGetUnreadMessageSucessState extends SocialState{}
class SocialGetUnreadMessageErrorState extends SocialState{}

class SocialDeleteUnreadMessageSucessState extends SocialState{}
class SocialDeleteUnreadMessageErrorState extends SocialState{}
class SocialChangelikeState extends SocialState{}

class SocialUpdateChatsucessState extends SocialState{}
class SocialUpdateChatErrorState extends SocialState{}
class SocialLoadpickchatImagesucess extends SocialState{}
class SocialLoadpickchatImageError extends SocialState{}

class SocialLoadchatImagesucess extends SocialState{}
class SocialLoadchatImageError extends SocialState{}

class Socialupdatetokensucess extends SocialState{}
class SocialupdatetokenError extends SocialState{}