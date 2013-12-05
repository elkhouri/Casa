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
    content = 'Grade: '+user.grade.to_s+'<br>Feedback:<br>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id ipsum ut orci cursus dictum. Ut dictum scelerisque interdum'
    content_tag(:a, image_tag(gravatar_url, alt: user.name), 
                class:'thumbnail', rel:'popover', title:user.name, :'data-content' => content,
                href:user.id)
  end
  
end
