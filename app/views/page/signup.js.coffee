'use strict'

clearErrors()

<% if @user.errors.any?
  @user.errors.full_messages.each do |error| %>

addError("<%= error %>")

<% end
else %>
$("#user-form").next().html("Thanks, <%= @user.name %>, for joining us! You opted <%= @user.subscribe %> <%= @user.subscribe ? 'in' : 'out' %>.<br/><%= @user.photo.url %>")
<% end %>