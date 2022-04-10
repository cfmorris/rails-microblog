module UsersHelper
  # returns the Gravatar for a given user
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end

  def validated_signup_label(param, user, f)
    if user.errors.full_messages_for(param).any?
      f.label param, user.errors.full_messages_for(param).first, style:"color:red;"
    else
      f.label param
    end     
  end
end
