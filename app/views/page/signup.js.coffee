'use strict'

window.clearErrors()

<% if @user.errors.any?
  @user.errors.full_messages.each do |error| %>

# reset submit button
$('#user-form .submit-form').button("reset")
window.addError("<%= error %>")

<% end
else %>
$("#user-form").slideUp()
$("#user-success").removeClass("hide")
$("#user-success .happy").hide(0)
$("#user-success .neutral").hide(0)
$("#user-success .sad").hide(0)
<% if @user.subscribe == "1"
    if !@user_already_subscribed %>
$("#user-success .happy").show(0)
<%  else %>
$("#user-success .neutral").show(0)
<%  end %>
<% else %>
$("#user-success .sad").show(0)
<% end %>
$("#user-success").slideDown()
<% end %>