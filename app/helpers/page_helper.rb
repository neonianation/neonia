module PageHelper
  
  def social_bar

    html = ""
    
    html += link_to "https://www.facebook.com/neonianation", :target => "_blank", :class => "social-icon" do
      image_tag "facebook.png"
    end
    
    html += link_to "https://google.com/+NeoniaOrganization", :target => "_blank", :class => "social-icon", :rel => "publisher" do
      image_tag "googleplus.png"
    end

    html += link_to "https://www.twitter.com/neonianation", :target => "_blank", :class => "social-icon" do
      image_tag "twitter.png"
    end

    return html
    
  end
end
