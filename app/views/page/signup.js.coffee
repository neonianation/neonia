'use strict'
  
$("#user-form").next().html("Thanks, <%= @user.name %>, for joining us! You opted <%= @user.subscribe %> <%= @user.subscribe ? 'in' : 'out' %>.<br/><%= @user.photo.url %>")