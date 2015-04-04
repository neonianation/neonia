'use strict'

window.clearErrors()

<% if @user.errors.any?
  @user.errors.full_messages.each do |error| %>

# reset submit button
$('#user-form .submit-form').button("reset")
window.addError("<%= error %>")

<% end
else %>
$("#user-success .name").html('<%= @user.name %>')
$("#user-form").slideUp()
$("#user-success").removeClass("hide")
$("#user-success").slideDown()

# count Piwik goal
Piwik.getAsyncTracker().trackGoal(3)
<% end %>