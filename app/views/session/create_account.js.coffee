'use strict'


window.clearErrors()

<% if @user and @user.errors.any? %>
  
# reset submit button
$('.submit-form').button("reset")

<% @user.errors.full_messages.each do |error| %>

window.addError("<%= error %>")

<% end %>
<% elsif @account_creation_was_successful %>

# count registration Piwik goal
Piwik.getAsyncTracker().trackGoal(7)

# hack to get the correct de-coded redirect url
div = document.createElement('div')
div.innerHTML = '<%= @redirect_path %>'
decoded_url = div.firstChild.nodeValue
window.location.href = decoded_url
<% end %>