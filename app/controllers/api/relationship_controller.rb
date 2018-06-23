class Api::RelationshipController < ApplicationController

  # this method is used to create friendship between two users
  def create
    if params[:friends].nil? || params[:friends].size != 2
      raise  ActiveRecord::RecordInvalid
    else
      requesting_user = User.find_by(email: params[:friends][0])
      accepting_user = User.find_by(email: params[:friends][1])
      if requesting_user && accepting_user && (requesting_user != accepting_user)
        message = requesting_user.make_friend(accepting_user)
        status = message && :ok || :unprocessable_entity
        json_response({success: message}, status)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end 

  #get the friend list by providing user email
  def friend_list
    if params[:email].nil?
      raise  ActiveRecord::RecordInvalid
    else
      requesting_user = User.find_by(email: params[:email])
      if requesting_user 
        friend_list = requesting_user.friend_list.pluck(:email)
        json_response({success: true, friends: friend_list, count: friend_list.size}, :ok)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end

  #This method is used to list common friends bwtween two emails
  def common_friends
    if params[:friends].nil? || params[:friends].size != 2
      raise  ActiveRecord::RecordInvalid
    else
      _user1 = User.find_by(email: params[:friends][0])
      _user2 = User.find_by(email: params[:friends][1])
      if _user1 && _user2 && (_user1 != _user2)
        common_friend_list = _user1.common_friends(_user2).pluck(:email)
        json_response({success: true, friends: common_friend_list, count:  common_friend_list.size}, :ok)
      else
        raise ActiveRecord::RecordNotFound
      end
      
    end
  end
end
