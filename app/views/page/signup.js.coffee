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
<% if @user.subscribe == "0" %>
$("#user-success .happy").hide(0)
<% else %>
$("#user-success .sad").hide(0)
<% end %>
$("#user-success").slideDown()
<% end %>