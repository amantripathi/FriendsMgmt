class Api::SubscriptionController < ApplicationController
  # this method is used to create subscription between two users
  def create
    if params[:requestor].nil? || params[:target].nil?
      raise  ActiveRecord::RecordInvalid
    else
      requesting_user = User.find_by(email: params[:requestor])
      targeting_user = User.find_by(email: params[:target])
      if requesting_user && targeting_user && (requesting_user != targeting_user)
        message = requesting_user.subscribe(targeting_user)
        status = message && :ok || :unprocessable_entity
        json_response({success: message}, status)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end 

  #This method is used to block user based on requestor and target
  def block
    if params[:requestor].nil? || params[:target].nil?
      raise  ActiveRecord::RecordInvalid
    else
      requesting_user = User.find_by(email: params[:requestor])
      targeting_user = User.find_by(email: params[:target])
      if requesting_user && targeting_user && (requesting_user != targeting_user)
        message = requesting_user.block(targeting_user)
        status = message && :ok || :unprocessable_entity
        json_response({success: message}, status)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end

  #This method is used to get all the reviever how will recieved  updates
  def reciever
    if params[:sender].nil? || params[:text].nil? 
      raise  ActiveRecord::RecordInvalid
    else
      sender = User.find_by(email: params[:sender])
      if sender
        recievers = sender.get_recipient_send_message(params[:text]).pluck(:email).uniq
        json_response({success: true, recipients: recievers, count:  recievers.size}, :ok)
      else
        raise ActiveRecord::RecordNotFound
      end
    end
  end
end