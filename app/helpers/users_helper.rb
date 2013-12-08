module UsersHelper
  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 100 })
    gravatar_id = Digest::MD5::hexdigest(user.name)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    image_tag(gravatar_url, alt: user.name)
  end
  
  def gravatar_thumbnail(user, options = { size: 100 })
    gravatar_id = Digest::MD5::hexdigest(user.name)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=mm"
    if user.checked_in?
      content = "Checked In<br>" << user.attendances.last.dropoff_time.to_s(:short) << "<br>By " << user.attendances.last.dropoff.name
    else
      content = "Last Checked Out<br>" << user.attendances.last.pickup_time.to_s(:short) << "<br>By " << user.attendances.last.pickup.name
    end
    
    content_tag(:a, image_tag(gravatar_url, alt: user.name), 
                class:'thumbnail', rel:'popover', title:user.name, :'data-content' => content,
                href:profile_user_path(user))
  end
  
end
