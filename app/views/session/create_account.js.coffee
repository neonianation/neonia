'use strict'


window.clearErrors()

<% if @user and @user.errors.any? %>
  
# reset submit button
$('.submit-form').button("reset")

<% @user.errors.full_messages.each do |error| %>

window.addError("<%= error %>")

<% end %>
<% elsif @account_creation_was_successful %>
window.location.href = "<%= @redirect_url %>"
<% end %>